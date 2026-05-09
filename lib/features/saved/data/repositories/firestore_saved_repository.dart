import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:app/features/saved/domain/repositories/saved_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SavedRepository)
class FirestoreSavedRepository implements SavedRepository {
  FirestoreSavedRepository(this._firestore);

  final FirebaseFirestore _firestore;

  // Oturum açmış kullanıcının uid'sini döndürür.
  // Null ise kullanıcı giriş yapmamış demektir.
  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  // Firestore dokümanını SavedQuestion entity'sine dönüştürür.
  SavedQuestion _mapDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data()!;
    return SavedQuestion(
      id: doc.id,
      questionId: data['questionId'] as String? ?? '',
      questionText: data['questionText'] as String? ?? '',
      categoryId: data['categoryId'] as String? ?? '',
      categoryTitle: data['categoryTitle'] as String? ?? '',
      savedAt: (data['savedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  @override
  Future<Result<List<SavedQuestion>>> getSavedQuestions() async {
    final String? uid = _userId;
    if (uid == null) {
      dev.log('⚠️ getSavedQuestions: kullanıcı giriş yapmamış', name: 'FirestoreSavedRepository');
      return const Success(<SavedQuestion>[]);
    }

    try {
      dev.log('🔖 Kaydedilen sorular çekiliyor | userId: $uid', name: 'FirestoreSavedRepository');

      final QuerySnapshot<Map<String, dynamic>> snap = await _firestore
          .collection('savedQuestions')
          .where('userId', isEqualTo: uid)
          .orderBy('savedAt', descending: true)
          .get();

      final List<SavedQuestion> questions = snap.docs.map(_mapDoc).toList();

      dev.log(
        '✅ Kaydedilen sorular hazır | count: ${questions.length}',
        name: 'FirestoreSavedRepository',
      );

      return Success(questions);
    } on Exception catch (e) {
      dev.log('❌ getSavedQuestions hatası: $e', name: 'FirestoreSavedRepository');
      return Failure(DataException('Kaydedilen sorular yüklenemedi: $e'));
    }
  }

  @override
  Future<Result<void>> saveQuestion({
    required String questionId,
    required String questionText,
    required String categoryId,
    required String categoryTitle,
  }) async {
    final String? uid = _userId;
    if (uid == null) {
      dev.log('⚠️ saveQuestion: kullanıcı giriş yapmamış', name: 'FirestoreSavedRepository');
      return Failure(DataException('Kaydetmek için giriş yapmalısınız.'));
    }

    try {
      // Doküman ID'si userId_questionId şeklinde; her kullanıcı-soru çifti benzersizdir.
      final String docId = '${uid}_$questionId';
      dev.log('🔖 Soru kaydediliyor | docId: $docId', name: 'FirestoreSavedRepository');

      await _firestore.collection('savedQuestions').doc(docId).set(<String, dynamic>{
        'userId': uid,
        'questionId': questionId,
        'questionText': questionText,
        'categoryId': categoryId,
        'categoryTitle': categoryTitle,
        'savedAt': FieldValue.serverTimestamp(),
      });

      dev.log('✅ Soru kaydedildi | docId: $docId', name: 'FirestoreSavedRepository');
      return const Success<void>(null);
    } on Exception catch (e) {
      dev.log('❌ saveQuestion hatası: $e', name: 'FirestoreSavedRepository');
      return Failure(DataException('Soru kaydedilemedi: $e'));
    }
  }

  @override
  Future<Result<void>> removeQuestion(String questionId) async {
    try {
      dev.log('🗑️ Soru siliniyor | questionId: $questionId', name: 'FirestoreSavedRepository');

      await _firestore.collection('savedQuestions').doc(questionId).delete();

      dev.log('✅ Soru silindi | questionId: $questionId', name: 'FirestoreSavedRepository');
      return const Success<void>(null);
    } on Exception catch (e) {
      dev.log('❌ removeQuestion hatası: $e', name: 'FirestoreSavedRepository');
      return Failure(DataException('Soru silinemedi: $e'));
    }
  }
}
