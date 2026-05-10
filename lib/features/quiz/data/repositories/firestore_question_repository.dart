import 'dart:convert';
import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

// Soruları Firestore'dan okur; yoksa Gemini ile üretip kaydeder.
// GeminiQuizRepository tarafından kullanılır.
@lazySingleton
class FirestoreQuestionRepository {
  FirestoreQuestionRepository(this._firestore, this._model);

  final FirebaseFirestore _firestore;
  final GenerativeModel _model;

  QuizQuestion _mapDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data()!;
    return QuizQuestion(
      id: doc.id,
      categoryId: data['categoryId'] as String? ?? '',
      text: data['text'] as String? ?? '',
      topic: data['topic'] as String? ?? '',
      difficulty: _parseDifficulty(data['difficulty'] as String?),
      order: data['order'] as int? ?? 0,
      answer: data['answer'] as String?,
      answerStatus: _parseAnswerStatus(data['answerStatus'] as String?),
    );
  }

  QuestionDifficulty _parseDifficulty(String? value) => switch (value) {
        'easy' => QuestionDifficulty.easy,
        'hard' => QuestionDifficulty.hard,
        _ => QuestionDifficulty.medium,
      };

  AnswerStatus _parseAnswerStatus(String? value) => switch (value) {
        'ready' => AnswerStatus.ready,
        'generating' => AnswerStatus.generating,
        _ => AnswerStatus.none,
      };

  Future<Result<List<QuizQuestion>>> getQuestions({
    required String categoryId,
    required bool isRandom,
    String? topicId,
  }) async {
    try {
      // Rastgele quiz: topicId ile tüm kategorilerdeki soruları çek ve karıştır.
      // Normal quiz: categoryId ile belirli kategorinin sorularını sıralı çek.
      final QuerySnapshot<Map<String, dynamic>> snap = isRandom && topicId != null
          ? await _firestore
              .collection('questions')
              .where('topicId', isEqualTo: topicId)
              .get()
          : await _firestore
              .collection('questions')
              .where('categoryId', isEqualTo: categoryId)
              .orderBy('order')
              .get();

      final List<QuizQuestion> questions = snap.docs.map(_mapDoc).toList();
      if (isRandom) questions.shuffle();

      dev.log(
        '📋 getQuestions | categoryId: $categoryId | count: ${questions.length}',
        name: 'FirestoreQuestionRepository',
      );
      return Success(questions);
    } on Exception catch (e) {
      dev.log('❌ getQuestions hata: $e', name: 'FirestoreQuestionRepository');
      return Failure(DataException('Sorular yüklenemedi.'));
    }
  }

  Future<Result<void>> generateQuestions({
    required String categoryId,
    required String topicId,
    required String topicName,
    required String categoryName,
  }) async {
    dev.log(
      '🤖 generateQuestions | category: $categoryName | topic: $topicName',
      name: 'FirestoreQuestionRepository',
    );

    try {
      // Kategori dokümanını 'generating' olarak işaretle.
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .update(<String, dynamic>{'questionsStatus': 'generating'});

      final String prompt = '''
Sen deneyimli bir yazılım geliştirici eğitmenisin.
Topic: $topicName
Konu: $categoryName

Bu konu için 7 mülakat sorusu oluştur. SADECE JSON formatında, Türkçe, başka hiçbir şey yazma:
[
  {"text": "Soru metni?", "difficulty": "easy", "topic": "$categoryName"},
  ...
]
difficulty değerleri: easy, medium, hard
''';

      final GenerateContentResponse response = await _model.generateContent(
        <Content>[Content.text(prompt)],
      );

      final String? text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Gemini boş yanıt döndü.');
      }

      // Markdown kod bloklarını temizle.
      final String cleaned = text
          .replaceAll(RegExp(r'```json\s*', multiLine: true), '')
          .replaceAll(RegExp(r'```\s*', multiLine: true), '')
          .trim();

      final List<dynamic> parsed = jsonDecode(cleaned) as List<dynamic>;

      // Soruları batch olarak Firestore'a yaz.
      final WriteBatch batch = _firestore.batch();
      final Timestamp now = Timestamp.now();

      for (int i = 0; i < parsed.length; i++) {
        final Map<String, dynamic> q = parsed[i] as Map<String, dynamic>;
        final DocumentReference<Map<String, dynamic>> ref =
            _firestore.collection('questions').doc();
        batch.set(ref, <String, dynamic>{
          'categoryId': categoryId,
          'topicId': topicId,
          'text': q['text'] ?? '',
          'topic': q['topic'] ?? categoryName,
          'difficulty': q['difficulty'] ?? 'medium',
          'order': i,
          'answerStatus': 'none',
          'createdAt': now,
        });
      }

      await batch.commit();

      // Kategori dokümanını güncelle.
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .update(<String, dynamic>{
        'questionsStatus': 'ready',
        'questionCount': parsed.length,
      });

      dev.log(
        '✅ Sorular yazıldı | count: ${parsed.length}',
        name: 'FirestoreQuestionRepository',
      );
      return const Success(null);
    } on Exception catch (e) {
      dev.log('❌ generateQuestions hata: $e',
          name: 'FirestoreQuestionRepository');
      // Başarısız olunca status'u sıfırla.
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .update(<String, dynamic>{'questionsStatus': 'none'})
          .catchError((_) {});
      return Failure(DataException('Sorular oluşturulamadı. Lütfen tekrar dene.'));
    }
  }
}
