import 'package:app/core/result/result.dart';
import 'package:app/features/category/domain/entities/study_category.dart';

// Kategori veri kaynağını soyutlayarak domain katmanını implementasyon detaylarından ayırır.
abstract interface class CategoryRepository {
  /// Firestore'dan verilen topic'e ait kategorileri getirir.
  Future<Result<List<StudyCategory>>> getCategories({required String topicId});

  /// Yoksa AI ile kategorileri üretir ve Firestore'a kaydeder.
  /// Race condition: başka kullanıcı üretiyorsa tamamlanana kadar bekler.
  Future<Result<void>> generateCategories({
    required String topicId,
    required String topicName,
    required String userId,
  });

  /// Bir kategorinin Firestore dokümanını gerçek zamanlı dinler.
  /// Race condition beklemesinde kullanılır.
  Stream<StudyCategory> watchCategory({required String categoryId});
}
