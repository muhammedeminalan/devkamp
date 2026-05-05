import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';

// Home ekranının ihtiyaç duyduğu verilerin kaynağını soyutlamak için kullanılır.
abstract interface class HomeRepository {
  Future<Result<List<Category>>> getCategories();
  Future<Result<LearningProgress>> getProgress();
}
