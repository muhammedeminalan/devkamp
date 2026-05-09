import 'package:app/core/result/result.dart';
import 'package:app/features/category/domain/repositories/category_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GenerateCategoriesUseCase {
  const GenerateCategoriesUseCase(this._repository);

  final CategoryRepository _repository;

  Future<Result<void>> call({
    required String topicId,
    required String topicName,
    required String userId,
  }) =>
      _repository.generateCategories(
        topicId: topicId,
        topicName: topicName,
        userId: userId,
      );
}
