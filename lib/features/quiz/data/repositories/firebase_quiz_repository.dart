import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/data/repositories/firestore_question_repository.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

// Soruları Firestore'dan okur; AI cevaplarını Firestore'a cache'ler.
// Kalıtım yerine composition: FirestoreQuestionRepository'yi delegate olarak kullanır.
@LazySingleton(as: QuizRepository)
class GeminiQuizRepository implements QuizRepository {
  GeminiQuizRepository(this._firestore, this._questionRepo) {
    _model = GenerativeModel(
      model: 'gemini-flash-latest',
      apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
    );
  }

  final FirebaseFirestore _firestore;
  final FirestoreQuestionRepository _questionRepo;
  late final GenerativeModel _model;

  @override
  Future<Result<List<QuizQuestion>>> getQuestions({
    required String categoryId,
    required bool isRandom,
    String? topicId,
  }) =>
      _questionRepo.getQuestions(
        categoryId: categoryId,
        isRandom: isRandom,
        topicId: topicId,
      );

  @override
  Future<Result<String>> getAiAnswer({
    required String questionId,
    required String questionText,
    required String topic,
    required String categoryId,
  }) async {
    dev.log(
      '▶ getAiAnswer | questionId: $questionId | topic: $topic',
      name: 'GeminiQuizRepository',
    );

    // Firestore cache kontrolü: questionId varsa önce cache'e bak.
    if (questionId.isNotEmpty) {
      try {
        final DocumentSnapshot<Map<String, dynamic>> snap =
            await _firestore.collection('questions').doc(questionId).get();

        if (snap.exists) {
          final Map<String, dynamic> data = snap.data()!;
          final String status = data['answerStatus'] as String? ?? 'none';
          final String? cachedAnswer = data['answer'] as String?;

          if (status == 'ready' && cachedAnswer != null && cachedAnswer.isNotEmpty) {
            dev.log('✅ Cache hit | questionId: $questionId',
                name: 'GeminiQuizRepository');
            return Success(cachedAnswer);
          }

          // Üretim başladığını işaretle.
          await snap.reference.update(<String, dynamic>{
            'answerStatus': 'generating',
          });
        }
      } on Exception catch (e) {
        dev.log('⚠️ Cache okuma hatası: $e', name: 'GeminiQuizRepository');
        // Cache hatası kritik değil; Gemini'ye devam et.
      }
    }

    // Gemini ile cevap üret.
    try {
      final String prompt = '''
Sen deneyimli bir Flutter/Dart eğitmenisin.
Konu: $topic
Kategori: $categoryId

Aşağıdaki mülakat sorusunu yanıtla. Cevabın:
- Kısa ve net olsun (maksimum 300 kelime)
- Kod örneği içeriyorsa Dart/Flutter kodu kullansın
- Markdown formatında olsun (bold, kod blokları, listeler)
- Türkçe olsun

Soru: $questionText
''';

      dev.log('📤 Gemini isteği gönderiliyor...', name: 'GeminiQuizRepository');

      final GenerateContentResponse response = await _model.generateContent(
        <Content>[Content.text(prompt)],
      );

      final String? text = response.text;
      if (text == null || text.isEmpty) {
        return const Failure(DataException('AI cevap üretemedi.'));
      }

      // Cevabı Firestore'a kaydet (sadece gerçek bir soru dokümanı varsa).
      if (questionId.isNotEmpty) {
        try {
          await _firestore
              .collection('questions')
              .doc(questionId)
              .update(<String, dynamic>{
            'answer': text,
            'answerStatus': 'ready',
          });
          dev.log('💾 Cevap cache\'lendi | questionId: $questionId',
              name: 'GeminiQuizRepository');
        } on Exception catch (e) {
          dev.log('⚠️ Cache yazma hatası: $e', name: 'GeminiQuizRepository');
        }
      }

      dev.log(
        '✅ Cevap üretildi | uzunluk: ${text.length}',
        name: 'GeminiQuizRepository',
      );
      return Success(text);
    } on Exception catch (e) {
      dev.log('❌ Gemini hatası: $e', name: 'GeminiQuizRepository');
      return Failure(DataException('Cevap şu an yüklenemiyor. İnternet bağlantını kontrol et.'));
    }
  }

  @override
  Future<Result<void>> generateQuestions({
    required String categoryId,
    required String topicId,
    required String topicName,
    required String categoryName,
  }) =>
      _questionRepo.generateQuestions(
        categoryId: categoryId,
        topicId: topicId,
        topicName: topicName,
        categoryName: categoryName,
      );
}
