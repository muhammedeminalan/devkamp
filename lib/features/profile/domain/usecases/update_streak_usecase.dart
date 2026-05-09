import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateStreakUseCase {
  const UpdateStreakUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<void>> call() => _repository.updateStreak();
}
