import 'package:app/features/category/domain/entities/study_category.dart';
import 'package:app/features/category/domain/repositories/category_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchCategoryUseCase {
  const WatchCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  Stream<StudyCategory> call({required String categoryId}) =>
      _repository.watchCategory(categoryId: categoryId);
}
