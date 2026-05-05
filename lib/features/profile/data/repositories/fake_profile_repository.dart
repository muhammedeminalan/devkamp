import 'package:app/core/constants/assets/app_svg_paths.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';
import 'package:app/features/profile/domain/repositories/profile_repository.dart';

class FakeProfileRepository implements ProfileRepository {
  @override
  Future<Result<UserStats>> getUserStats() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return const Success<UserStats>(
      UserStats(
        totalSolved: 87,
        correctAnswers: 72,
        streakDays: 5,
        accuracy: 0.827,
        rank: 'Orta Seviye',
      ),
    );
  }

  @override
  Future<Result<List<Achievement>>> getAchievements() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return const Success<List<Achievement>>(<Achievement>[
      Achievement(
        id: 'first_solve',
        title: 'İlk Çözüm',
        description: 'İlk soruyu çözdün',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: true,
      ),
      Achievement(
        id: 'streak_5',
        title: '5 Günlük Seri',
        description: '5 gün üst üste çalıştın',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: true,
      ),
      Achievement(
        id: 'streak_30',
        title: '30 Günlük Seri',
        description: '30 gün üst üste çalış',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: false,
      ),
    ]);
  }
}
