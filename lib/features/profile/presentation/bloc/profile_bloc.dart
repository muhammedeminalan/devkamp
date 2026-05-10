import 'dart:developer' as dev;

import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:app/features/profile/domain/entities/category_performance.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';
import 'package:app/features/profile/domain/usecases/get_achievements_usecase.dart';
import 'package:app/features/profile/domain/usecases/get_category_performance_usecase.dart';
import 'package:app/features/profile/domain/usecases/get_user_stats_usecase.dart';
import 'package:app/features/profile/presentation/bloc/profile_event.dart';
import 'package:app/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetUserStatsUseCase getUserStatsUseCase,
    required GetAchievementsUseCase getAchievementsUseCase,
    required GetCategoryPerformanceUseCase getCategoryPerformanceUseCase,
  })  : _getStats = getUserStatsUseCase,
        _getAchievements = getAchievementsUseCase,
        _getCategoryPerformance = getCategoryPerformanceUseCase,
        super(const ProfileState()) {
    on<ProfileDataLoaded>(_onLoaded);
  }

  final GetUserStatsUseCase _getStats;
  final GetAchievementsUseCase _getAchievements;
  final GetCategoryPerformanceUseCase _getCategoryPerformance;

  Future<void> _onLoaded(
    ProfileDataLoaded event,
    Emitter<ProfileState> emit,
  ) async {
    dev.log('👤 Profil verileri yükleniyor...', name: 'ProfileBloc');
    emit(state.copyWith(status: ProfileStatus.loading));

    // Her sonuç doğru generic tipiyle alınır; unsafe cast gereksiz.
    final (
      Result<UserStats> statsResult,
      Result<List<Achievement>> achievementsResult,
      Result<List<CategoryPerformance>> categoryResult,
    ) = await (
      _getStats(),
      _getAchievements(),
      _getCategoryPerformance(),
    ).wait;

    if (statsResult is Failure<UserStats>) {
      dev.log('❌ Profil yükleme hatası: ${statsResult.exception.message}', name: 'ProfileBloc');
      emit(state.copyWith(status: ProfileStatus.failure, errorMessage: statsResult.exception.message));
      return;
    }

    if (achievementsResult is Failure<List<Achievement>>) {
      dev.log('❌ Profil yükleme hatası: ${achievementsResult.exception.message}', name: 'ProfileBloc');
      emit(state.copyWith(status: ProfileStatus.failure, errorMessage: achievementsResult.exception.message));
      return;
    }

    // Kategori performansı kritik değil; hata olsa da devam edilir.
    final List<CategoryPerformance> categoryPerf =
        categoryResult is Success<List<CategoryPerformance>> ? categoryResult.data : <CategoryPerformance>[];

    dev.log('✅ Profil verileri hazır | kategori: ${categoryPerf.length}', name: 'ProfileBloc');
    emit(
      state.copyWith(
        status: ProfileStatus.success,
        stats: (statsResult as Success<UserStats>).data,
        achievements: (achievementsResult as Success<List<Achievement>>).data,
        categoryPerformance: categoryPerf,
      ),
    );
  }
}
