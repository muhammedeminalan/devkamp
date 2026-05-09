import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:app/features/topic/domain/repositories/topic_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TopicRepository)
class FirestoreTopicRepository implements TopicRepository {
  FirestoreTopicRepository(this._firestore);

  final FirebaseFirestore _firestore;

  // Firestore categories dokümanını Topic entity'sine dönüştürür.
  // categoryId parametresi burada topicId olarak kullanılır (flutter, dart, python).
  Topic _mapDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data()!;
    return Topic(
      id: doc.id,
      name: data['name'] as String? ?? '',
      difficulty: TopicDifficulty.medium,
      questionCount: data['questionCount'] as int? ?? 0,
      isDone: false,
    );
  }

  @override
  Future<Result<List<Topic>>> getTopics({required String categoryId}) async {
    try {
      dev.log(
        '📚 Topics çekiliyor | topicId: $categoryId',
        name: 'FirestoreTopicRepository',
      );

      // AI tarafından üretilen kategorileri topic listesi olarak kullanır.
      final QuerySnapshot<Map<String, dynamic>> snap = await _firestore
          .collection('categories')
          .where('topicId', isEqualTo: categoryId)
          .where('status', isEqualTo: 'ready')
          .orderBy('createdAt')
          .get();

      final List<Topic> topics = snap.docs.map(_mapDoc).toList();

      dev.log(
        '✅ Topics hazır | count: ${topics.length}',
        name: 'FirestoreTopicRepository',
      );

      return Success(topics);
    } on Exception catch (e) {
      dev.log('❌ getTopics hatası: $e', name: 'FirestoreTopicRepository');
      return Failure(DataException('Konular yüklenemedi: $e'));
    }
  }
}
