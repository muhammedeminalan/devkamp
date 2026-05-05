import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';
import 'package:app/features/profile/domain/repositories/profile_repository.dart';

class GetUserStatsUseCase {
  const GetUserStatsUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<UserStats>> call() => _repository.getUserStats();
}

class GetAchievementsUseCase {
  const GetAchievementsUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<List<Achievement>>> call() => _repository.getAchievements();
}
