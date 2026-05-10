import 'dart:developer' as dev;

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
    on<SavedFilterChanged>(_onSavedFilterChanged);
  }

  final GetSavedQuestionsUseCase _getSavedQuestionsUseCase;
  final RemoveSavedQuestionUseCase _removeSavedQuestionUseCase;

  Future<void> _onSavedQuestionsLoaded(
    SavedQuestionsLoaded event,
    Emitter<SavedState> emit,
  ) async {
    dev.log('🔖 Kaydedilen sorular yükleniyor...', name: 'SavedBloc');
    emit(state.copyWith(status: SavedStatus.loading));

    final Result<List<SavedQuestion>> result = await _getSavedQuestionsUseCase();
    if (result is Failure<List<SavedQuestion>>) {
      dev.log('❌ Kaydedilen sorular yüklenemedi: ${result.exception.message}', name: 'SavedBloc');
      emit(
        state.copyWith(
          status: SavedStatus.failure,
          errorMessage: result.exception.message,
        ),
      );
      return;
    }

    final List<SavedQuestion> questions = (result as Success<List<SavedQuestion>>).data;
    dev.log('✅ Kaydedilen sorular hazır | count: ${questions.length}', name: 'SavedBloc');
    emit(
      state.copyWith(
        status: SavedStatus.success,
        questions: questions,
      ),
    );
  }

  void _onSavedFilterChanged(
    SavedFilterChanged event,
    Emitter<SavedState> emit,
  ) {
    // Yalnızca seçili filtre değiştiğinde yeni state yayılır; senkron işlem.
    emit(state.copyWith(selectedFilterId: event.filterId));
  }

  Future<void> _onSavedQuestionRemoved(
    SavedQuestionRemoved event,
    Emitter<SavedState> emit,
  ) async {
    dev.log('🗑️ Soru siliniyor | questionId: ${event.questionId}', name: 'SavedBloc');
    final List<SavedQuestion> previousQuestions = state.questions;
    final List<SavedQuestion> updatedQuestions = previousQuestions
        .where((SavedQuestion question) => question.id != event.questionId)
        .toList();

    emit(
      state.copyWith(
        status: SavedStatus.success,
        questions: updatedQuestions,
      ),
    );

    final Result<void> removeResult = await _removeSavedQuestionUseCase(
      event.questionId,
    );

    if (removeResult is Failure<void>) {
      dev.log(
        '❌ Soru silinemedi, geri alınıyor | error: ${removeResult.exception.message}',
        name: 'SavedBloc',
      );
      emit(
        state.copyWith(
          status: SavedStatus.failure,
          questions: previousQuestions,
          errorMessage: removeResult.exception.message,
        ),
      );
    } else {
      dev.log('✅ Soru silindi | questionId: ${event.questionId}', name: 'SavedBloc');
    }
  }
}
