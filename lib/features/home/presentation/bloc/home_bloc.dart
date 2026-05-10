import 'dart:developer' as dev;

import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/entities/last_session.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:app/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:app/features/home/domain/usecases/get_last_session_usecase.dart';
import 'package:app/features/home/domain/usecases/get_progress_usecase.dart';
import 'package:app/features/home/presentation/bloc/home_event.dart';
import 'package:app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetProgressUseCase getProgressUseCase,
    required GetLastSessionUseCase getLastSessionUseCase,
  })  : _getCategories = getCategoriesUseCase,
        _getProgress = getProgressUseCase,
        _getLastSession = getLastSessionUseCase,
        super(const HomeState()) {
    on<HomeDataLoaded>(_onHomeDataLoaded);
  }

  final GetCategoriesUseCase _getCategories;
  final GetProgressUseCase _getProgress;
  final GetLastSessionUseCase _getLastSession;

  Future<void> _onHomeDataLoaded(
    HomeDataLoaded event,
    Emitter<HomeState> emit,
  ) async {
    dev.log('🏠 Home verileri yükleniyor...', name: 'HomeBloc');
    emit(state.copyWith(status: HomeStatus.loading));

    // Kategoriler, ilerleme ve son oturumu paralel çek; her sonuç doğru tiple gelir.
    final (
      Result<List<Category>> categoriesResult,
      Result<LearningProgress> progressResult,
      Result<LastSession?> lastSessionResult,
    ) = await (
      _getCategories(),
      _getProgress(),
      _getLastSession(),
    ).wait;

    if (categoriesResult is Failure<List<Category>>) {
      dev.log('❌ Home yükleme hatası: ${categoriesResult.exception.message}', name: 'HomeBloc');
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: categoriesResult.exception.message,
        ),
      );
      return;
    }

    if (progressResult is Failure<LearningProgress>) {
      dev.log('❌ Home yükleme hatası: ${progressResult.exception.message}', name: 'HomeBloc');
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: progressResult.exception.message,
        ),
      );
      return;
    }

    // lastSession hatası kritik değil; null olarak devam edilir.
    final LastSession? lastSession =
        lastSessionResult is Success<LastSession?> ? lastSessionResult.data : null;

    final List<Category> cats = (categoriesResult as Success<List<Category>>).data;
    dev.log(
      '✅ Home verileri hazır | kategori: ${cats.length} | lastSession: ${lastSession?.topicName ?? 'yok'}',
      name: 'HomeBloc',
    );

    emit(
      state.copyWith(
        status: HomeStatus.success,
        categories: cats,
        progress: (progressResult as Success<LearningProgress>).data,
        lastSession: lastSession,
      ),
    );
  }
}
