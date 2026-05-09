import 'dart:developer' as dev;

import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:app/features/profile/domain/entities/category_performance.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';
import 'package:app/features/profile/domain/usecases/get_category_performance_usecase.dart';
import 'package:app/features/profile/domain/usecases/get_user_stats_usecase.dart';
import 'package:app/features/profile/presentation/bloc/profile_event.dart';
import 'package:app/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    final List<Result<dynamic>> results = await Future.wait(<Future<Result<dynamic>>>[
      _getStats(),
      _getAchievements(),
      _getCategoryPerformance(),
    ]);

    final Result<dynamic> statsResult = results[0];
    final Result<dynamic> achievementsResult = results[1];
    final Result<dynamic> categoryResult = results[2];

    if (statsResult is Failure || achievementsResult is Failure) {
      final String error = statsResult is Failure
          ? statsResult.exception.message
          : (achievementsResult as Failure).exception.message;
      dev.log('❌ Profil yükleme hatası: $error', name: 'ProfileBloc');
      emit(state.copyWith(status: ProfileStatus.failure, errorMessage: error));
      return;
    }

    // Kategori performansı kritik değil; hata olsa da devam edilir.
    final List<CategoryPerformance> categoryPerf = categoryResult is Success
        ? (categoryResult as Success<List<CategoryPerformance>>).data
        : <CategoryPerformance>[];

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
