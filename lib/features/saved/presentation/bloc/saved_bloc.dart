import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:app/features/saved/domain/usecases/get_saved_questions_usecase.dart';
import 'package:app/features/saved/domain/usecases/remove_saved_question_usecase.dart';
import 'package:app/features/saved/presentation/bloc/saved_event.dart';
import 'package:app/features/saved/presentation/bloc/saved_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc({
    required GetSavedQuestionsUseCase getSavedQuestionsUseCase,
    required RemoveSavedQuestionUseCase removeSavedQuestionUseCase,
  })  : _getSavedQuestionsUseCase = getSavedQuestionsUseCase,
        _removeSavedQuestionUseCase = removeSavedQuestionUseCase,
        super(const SavedState()) {
    on<SavedQuestionsLoaded>(_onSavedQuestionsLoaded);
    on<SavedQuestionRemoved>(_onSavedQuestionRemoved);
  }

  final GetSavedQuestionsUseCase _getSavedQuestionsUseCase;
  final RemoveSavedQuestionUseCase _removeSavedQuestionUseCase;

  Future<void> _onSavedQuestionsLoaded(
    SavedQuestionsLoaded event,
    Emitter<SavedState> emit,
  ) async {
    emit(state.copyWith(status: SavedStatus.loading));

    final Result<List<SavedQuestion>> result = await _getSavedQuestionsUseCase();
    if (result is Failure<List<SavedQuestion>>) {
      emit(
        state.copyWith(
          status: SavedStatus.failure,
          errorMessage: result.exception.message,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SavedStatus.success,
        questions: (result as Success<List<SavedQuestion>>).data,
      ),
    );
  }

  Future<void> _onSavedQuestionRemoved(
    SavedQuestionRemoved event,
    Emitter<SavedState> emit,
  ) async {
    final Result<void> removeResult = await _removeSavedQuestionUseCase(
      event.questionId,
    );

    if (removeResult is Failure<void>) {
      emit(
        state.copyWith(
          status: SavedStatus.failure,
          errorMessage: removeResult.exception.message,
        ),
      );
      return;
    }

    add(const SavedQuestionsLoaded());
  }
}
