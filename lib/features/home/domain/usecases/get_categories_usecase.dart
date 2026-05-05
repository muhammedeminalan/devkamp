import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/repositories/home_repository.dart';

class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final HomeRepository _repository;

  Future<Result<List<Category>>> call() => _repository.getCategories();
}
