import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:app/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:app/features/home/domain/usecases/get_progress_usecase.dart';
import 'package:app/features/home/presentation/bloc/home_event.dart';
import 'package:app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetProgressUseCase getProgressUseCase,
  })  : _getCategories = getCategoriesUseCase,
        _getProgress = getProgressUseCase,
        super(const HomeState()) {
    on<HomeDataLoaded>(_onHomeDataLoaded);
  }

  final GetCategoriesUseCase _getCategories;
  final GetProgressUseCase _getProgress;

  Future<void> _onHomeDataLoaded(
    HomeDataLoaded event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final List<Result<dynamic>> results = await Future.wait(<Future<Result<dynamic>>>[
      _getCategories(),
      _getProgress(),
    ]);

    final Result<dynamic> categoriesResult = results[0];
    final Result<dynamic> progressResult = results[1];

    if (categoriesResult is Failure || progressResult is Failure) {
      final String errorMessage;
      if (categoriesResult is Failure) {
        errorMessage = categoriesResult.exception.message;
      } else {
        errorMessage = (progressResult as Failure).exception.message;
      }

      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: errorMessage,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: HomeStatus.success,
        categories: (categoriesResult as Success<List<Category>>).data,
        progress: (progressResult as Success<LearningProgress>).data,
      ),
    );
  }
}
