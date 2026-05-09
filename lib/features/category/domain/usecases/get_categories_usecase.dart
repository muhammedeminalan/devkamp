import 'package:app/core/result/result.dart';
import 'package:app/features/category/domain/entities/study_category.dart';
import 'package:app/features/category/domain/repositories/category_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final CategoryRepository _repository;

  Future<Result<List<StudyCategory>>> call({required String topicId}) =>
      _repository.getCategories(topicId: topicId);
}
