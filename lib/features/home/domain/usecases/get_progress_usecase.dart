import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:app/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProgressUseCase {
  const GetProgressUseCase(this._repository);

  final HomeRepository _repository;

  Future<Result<LearningProgress>> call() => _repository.getProgress();
}
