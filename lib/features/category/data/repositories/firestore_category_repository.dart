import 'dart:convert';
import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/category/domain/entities/study_category.dart';
import 'package:app/features/category/domain/repositories/category_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryRepository)
class FirestoreCategoryRepository implements CategoryRepository {
  FirestoreCategoryRepository(this._firestore, this._model);

  final FirebaseFirestore _firestore;
  final GenerativeModel _model;

  // Firestore dokümanını StudyCategory entity'sine dönüştürür.
  StudyCategory _mapDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data()!;
    return StudyCategory(
      id: doc.id,
      topicId: data['topicId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      status: _parseStatus(data['status'] as String?),
      questionsStatus:
          _parseQuestionsStatus(data['questionsStatus'] as String?),
      questionCount: data['questionCount'] as int? ?? 0,
      createdBy: data['createdBy'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  CategoryStatus _parseStatus(String? value) => switch (value) {
        'ready' => CategoryStatus.ready,
        'error' => CategoryStatus.error,
        _ => CategoryStatus.generating,
      };

  QuestionsStatus _parseQuestionsStatus(String? value) => switch (value) {
        'ready' => QuestionsStatus.ready,
        'generating' => QuestionsStatus.generating,
        _ => QuestionsStatus.none,
      };

  @override
  Future<Result<List<StudyCategory>>> getCategories({
    required String topicId,
  }) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snap = await _firestore
          .collection('categories')
          .where('topicId', isEqualTo: topicId)
          .where('status', isEqualTo: 'ready')
          .orderBy('createdAt')
          .get();

      final List<StudyCategory> categories = snap.docs.map(_mapDoc).toList();
      dev.log(
        '📂 getCategories | topicId: $topicId | count: ${categories.length}',
        name: 'FirestoreCategoryRepository',
      );
      return Success(categories);
    } on Exception catch (e) {
      dev.log('❌ getCategories hata: $e', name: 'FirestoreCategoryRepository');
      return Failure(DataException('Kategoriler yüklenemedi: $e'));
    }
  }

  @override
  Future<Result<void>> generateCategories({
    required String topicId,
    required String topicName,
    required String userId,
  }) async {
    // Lock dokümanı: yarış durumunu önlemek için atomik kontrol.
    final DocumentReference<Map<String, dynamic>> lockRef =
        _firestore.collection('categoryGenerations').doc(topicId);

    bool gotLock = false;

    try {
      await _firestore.runTransaction((Transaction tx) async {
        final DocumentSnapshot<Map<String, dynamic>> snap =
            await tx.get(lockRef);
        final String? currentStatus =
            snap.exists ? (snap.data()?['status'] as String?) : null;

        // Eğer 'generating' veya 'ready' ise lock alma; hata durumunda yeniden dene.
        if (currentStatus == 'generating' || currentStatus == 'ready') {
          return;
        }

        tx.set(lockRef, <String, dynamic>{
          'status': 'generating',
          'topicId': topicId,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        gotLock = true;
      });

      if (gotLock) {
        // Biz üretiyoruz.
        dev.log(
          '🔒 Lock alındı, kategoriler üretiliyor | topicId: $topicId',
          name: 'FirestoreCategoryRepository',
        );
        await _generateAndSave(
          topicId: topicId,
          topicName: topicName,
          userId: userId,
          lockRef: lockRef,
        );
      } else {
        // Başka kullanıcı üretiyor; tamamlanmasını bekle.
        dev.log(
          '⏳ Başka kullanıcı üretiyor, bekleniyor | topicId: $topicId',
          name: 'FirestoreCategoryRepository',
        );
        await _waitForGeneration(lockRef);
      }

      return const Success(null);
    } on Exception catch (e) {
      dev.log(
        '❌ generateCategories hata: $e',
        name: 'FirestoreCategoryRepository',
      );
      return Failure(DataException('Kategoriler üretilemedi: $e'));
    }
  }

  // Gemini ile kategorileri üretir ve Firestore'a batch yazar.
  Future<void> _generateAndSave({
    required String topicId,
    required String topicName,
    required String userId,
    required DocumentReference<Map<String, dynamic>> lockRef,
  }) async {
    try {
      final String prompt = '''
Sen deneyimli bir yazılım geliştirici eğitmenisin.
$topicName için mülakat hazırlık konuları oluştur.

8 farklı kategori başlığı döndür. SADECE JSON array formatında, Türkçe, başka hiçbir şey yazma:
["Kategori 1", "Kategori 2", ...]
''';

      dev.log('📤 Gemini kategori isteği | topicName: $topicName',
          name: 'FirestoreCategoryRepository');

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

      final List<dynamic> names = jsonDecode(cleaned) as List<dynamic>;

      // Batch write: her kategori ayrı Firestore dokümanı.
      final WriteBatch batch = _firestore.batch();
      final Timestamp now = Timestamp.now();

      for (final dynamic name in names) {
        final DocumentReference<Map<String, dynamic>> ref =
            _firestore.collection('categories').doc();
        batch.set(ref, <String, dynamic>{
          'topicId': topicId,
          'name': name.toString(),
          'status': 'ready',
          'questionsStatus': 'none',
          'questionCount': 0,
          'createdBy': userId,
          'createdAt': now,
        });
      }

      await batch.commit();

      // Lock'ı 'ready' olarak güncelle; izleyen kullanıcıları bilgilendirir.
      await lockRef.update(<String, dynamic>{
        'status': 'ready',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      dev.log(
        '✅ Kategoriler yazıldı | count: ${names.length}',
        name: 'FirestoreCategoryRepository',
      );
    } catch (e) {
      // Üretim başarısız olunca lock'ı 'error' yap; tekrar denenebilsin.
      await lockRef.update(<String, dynamic>{
        'status': 'error',
        'updatedAt': FieldValue.serverTimestamp(),
      });
      rethrow;
    }
  }

  // Lock dokümanı 'ready' veya 'error' olana kadar bekler (max 60 sn).
  Future<void> _waitForGeneration(
    DocumentReference<Map<String, dynamic>> lockRef,
  ) async {
    await lockRef
        .snapshots()
        .timeout(const Duration(seconds: 60))
        .firstWhere((DocumentSnapshot<Map<String, dynamic>> snap) {
      final String? status = snap.data()?['status'] as String?;
      return status == 'ready' || status == 'error';
    });
  }

  @override
  Stream<StudyCategory> watchCategory({required String categoryId}) {
    return _firestore
        .collection('categories')
        .doc(categoryId)
        .snapshots()
        .where(
          (DocumentSnapshot<Map<String, dynamic>> snap) => snap.exists,
        )
        .map(_mapDoc);
  }
}
