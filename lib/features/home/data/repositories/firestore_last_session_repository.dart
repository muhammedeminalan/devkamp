import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/last_session.dart';
import 'package:app/features/home/domain/repositories/last_session_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LastSessionRepository)
class FirestoreLastSessionRepository implements LastSessionRepository {
  FirestoreLastSessionRepository(this._firestore);

  final FirebaseFirestore _firestore;

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<Result<LastSession?>> getLastSession() async {
    final String? uid = _userId;
    if (uid == null) {
      dev.log('⚠️ getLastSession: kullanıcı giriş yapmamış', name: 'FirestoreLastSessionRepository');
      return const Success(null);
    }

    try {
      dev.log('📖 Son oturum çekiliyor | userId: $uid', name: 'FirestoreLastSessionRepository');

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('lastSession').doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        dev.log('📖 Son oturum bulunamadı | userId: $uid', name: 'FirestoreLastSessionRepository');
        return const Success(null);
      }

      final Map<String, dynamic> data = doc.data()!;

      final LastSession session = LastSession(
        categoryId: data['categoryId'] as String? ?? '',
        categoryName: data['categoryName'] as String? ?? '',
        topicId: data['topicId'] as String?,
        topicName: data['topicName'] as String? ?? '',
        isRandom: data['isRandom'] as bool? ?? false,
        savedAt: (data['savedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );

      dev.log(
        '✅ Son oturum hazır | category: ${session.categoryName} | topic: ${session.topicName}',
        name: 'FirestoreLastSessionRepository',
      );
      return Success(session);
    } on Exception catch (e) {
      dev.log('❌ getLastSession hatası: $e', name: 'FirestoreLastSessionRepository');
      return Failure(DataException('Son oturum yüklenemedi: $e'));
    }
  }

  @override
  Future<Result<void>> saveLastSession(LastSession session) async {
    final String? uid = _userId;
    if (uid == null) {
      dev.log('⚠️ saveLastSession: kullanıcı giriş yapmamış', name: 'FirestoreLastSessionRepository');
      return const Success(null);
    }

    try {
      dev.log(
        '💾 Son oturum kaydediliyor | category: ${session.categoryName} | topic: ${session.topicName}',
        name: 'FirestoreLastSessionRepository',
      );

      await _firestore.collection('lastSession').doc(uid).set(
        <String, dynamic>{
          'categoryId': session.categoryId,
          'categoryName': session.categoryName,
          'topicId': session.topicId,
          'topicName': session.topicName,
          'isRandom': session.isRandom,
          'savedAt': FieldValue.serverTimestamp(),
        },
      );

      dev.log('✅ Son oturum kaydedildi', name: 'FirestoreLastSessionRepository');
      return const Success(null);
    } on Exception catch (e) {
      dev.log('❌ saveLastSession hatası: $e', name: 'FirestoreLastSessionRepository');
      return Failure(DataException('Son oturum kaydedilemedi: $e'));
    }
  }
}
