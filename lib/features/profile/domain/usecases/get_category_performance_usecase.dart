import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/entities/category_performance.dart';
import 'package:app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoryPerformanceUseCase {
  const GetCategoryPerformanceUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<List<CategoryPerformance>>> call() =>
      _repository.getCategoryPerformance();
}
