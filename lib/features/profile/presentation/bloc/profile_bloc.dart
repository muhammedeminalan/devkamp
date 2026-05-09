import 'dart:developer' as dev;

import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';
import 'package:app/features/profile/domain/usecases/get_user_stats_usecase.dart';
import 'package:app/features/profile/presentation/bloc/profile_event.dart';
import 'package:app/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required GetUserStatsUseCase getUserStatsUseCase,
    required GetAchievementsUseCase getAchievementsUseCase,
  })  : _getStats = getUserStatsUseCase,
        _getAchievements = getAchievementsUseCase,
        super(const ProfileState()) {
    on<ProfileDataLoaded>(_onLoaded);
  }

  final GetUserStatsUseCase _getStats;
  final GetAchievementsUseCase _getAchievements;

  Future<void> _onLoaded(
    ProfileDataLoaded event,
    Emitter<ProfileState> emit,
  ) async {
    dev.log('👤 Profil verileri yükleniyor...', name: 'ProfileBloc');
    emit(state.copyWith(status: ProfileStatus.loading));

    final List<Result<dynamic>> results = await Future.wait(<Future<Result<dynamic>>>[
      _getStats(),
      _getAchievements(),
    ]);

    final Result<dynamic> statsResult = results[0];
    final Result<dynamic> achievementsResult = results[1];

    if (statsResult is Failure || achievementsResult is Failure) {
      final String error;
      if (statsResult is Failure) {
        error = statsResult.exception.message;
      } else {
        error = (achievementsResult as Failure).exception.message;
      }
      dev.log('❌ Profil yükleme hatası: $error', name: 'ProfileBloc');
      emit(state.copyWith(status: ProfileStatus.failure, errorMessage: error));
      return;
    }

    dev.log('✅ Profil verileri hazır', name: 'ProfileBloc');
    emit(
      state.copyWith(
        status: ProfileStatus.success,
        stats: (statsResult as Success<UserStats>).data,
        achievements:
            (achievementsResult as Success<List<Achievement>>).data,
      ),
    );
  }
}
