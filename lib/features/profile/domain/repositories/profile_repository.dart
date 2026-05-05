import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';

abstract interface class ProfileRepository {
  Future<Result<UserStats>> getUserStats();
  Future<Result<List<Achievement>>> getAchievements();
}
