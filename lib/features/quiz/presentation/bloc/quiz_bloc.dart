import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:app/features/quiz/domain/usecases/get_ai_answer_usecase.dart';
import 'package:app/features/quiz/domain/usecases/get_quiz_questions_usecase.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required GetQuizQuestionsUseCase getQuizQuestionsUseCase,
    required GetAiAnswerUseCase getAiAnswerUseCase,
  })  : _getQuestions = getQuizQuestionsUseCase,
        _getAiAnswer = getAiAnswerUseCase,
        super(const QuizState()) {
    on<QuizStarted>(_onQuizStarted);
    on<QuizAnswerRequested>(_onAnswerRequested);
    on<QuizAnswerStreamComplete>(_onAnswerStreamComplete);
    on<QuizEvaluated>(_onEvaluated);
    on<QuizNextQuestion>(_onNextQuestion);
    on<QuizRestarted>(_onRestarted);
    on<QuizQuestionBookmarked>(_onBookmarked);
    on<QuizAnswerRetried>(_onAnswerRetried);
  }

  final GetQuizQuestionsUseCase _getQuestions;
  final GetAiAnswerUseCase _getAiAnswer;

  Future<void> _onQuizStarted(
    QuizStarted event,
    Emitter<QuizState> emit,
  ) async {
    emit(state.copyWith(status: QuizStatus.loading));

    final Result<List<QuizQuestion>> result = await _getQuestions(
      categoryId: event.categoryId,
      topicId: event.topicId,
      isRandom: event.isRandom,
    );

    switch (result) {
      case Success<List<QuizQuestion>>():
        emit(state.copyWith(
          status: QuizStatus.question,
          questions: result.data,
          currentIndex: 0,
          answerStage: AnswerStage.hidden,
          evalResult: EvalResult.none,
          isBookmarked: false,
          knewIndices: <int>{},
          missedIndices: <int>{},
        ));
      case Failure<List<QuizQuestion>>():
        emit(state.copyWith(
          status: QuizStatus.failure,
          errorMessage: result.exception.message,
        ));
    }
  }

  Future<void> _onAnswerRequested(
    QuizAnswerRequested event,
    Emitter<QuizState> emit,
  ) async {
    emit(state.copyWith(answerStage: AnswerStage.loading));

    final QuizQuestion? q = state.currentQuestion;
    if (q == null) return;

    final Result<String> result = await _getAiAnswer(questionId: q.id);

    switch (result) {
      case Success<String>():
        emit(state.copyWith(
          answerStage: AnswerStage.streaming,
          answerText: result.data,
        ));
      case Failure<String>():
        emit(state.copyWith(
          answerStage: AnswerStage.error,
          errorMessage: result.exception.message,
        ));
    }
  }

  void _onAnswerStreamComplete(
    QuizAnswerStreamComplete event,
    Emitter<QuizState> emit,
  ) {
    emit(state.copyWith(answerStage: AnswerStage.answered));
  }

  void _onEvaluated(
    QuizEvaluated event,
    Emitter<QuizState> emit,
  ) {
    final Set<int> knewIndices = Set<int>.from(state.knewIndices);
    final Set<int> missedIndices = Set<int>.from(state.missedIndices);

    knewIndices.remove(state.currentIndex);
    missedIndices.remove(state.currentIndex);

    if (event.knew) {
      knewIndices.add(state.currentIndex);
    } else {
      missedIndices.add(state.currentIndex);
    }

    emit(state.copyWith(
      evalResult: event.knew ? EvalResult.knew : EvalResult.missed,
      knewIndices: knewIndices,
      missedIndices: missedIndices,
    ));
  }

  void _onNextQuestion(
    QuizNextQuestion event,
    Emitter<QuizState> emit,
  ) {
    if (state.isLastQuestion) {
      emit(state.copyWith(status: QuizStatus.complete));
      return;
    }

    emit(state.copyWith(
      currentIndex: state.currentIndex + 1,
      answerStage: AnswerStage.hidden,
      evalResult: EvalResult.none,
      isBookmarked: false,
      answerText: null,
      errorMessage: null,
    ));
  }

  Future<void> _onRestarted(
    QuizRestarted event,
    Emitter<QuizState> emit,
  ) async {
    if (state.questions.isEmpty) return;

    final List<QuizQuestion> reshuffled =
        List<QuizQuestion>.from(state.questions)..shuffle();

    emit(state.copyWith(
      status: QuizStatus.question,
      questions: reshuffled,
      currentIndex: 0,
      answerStage: AnswerStage.hidden,
      evalResult: EvalResult.none,
      isBookmarked: false,
      knewIndices: <int>{},
      missedIndices: <int>{},
      answerText: null,
      errorMessage: null,
    ));
  }

  void _onBookmarked(
    QuizQuestionBookmarked event,
    Emitter<QuizState> emit,
  ) {
    emit(state.copyWith(isBookmarked: !state.isBookmarked));
  }

  Future<void> _onAnswerRetried(
    QuizAnswerRetried event,
    Emitter<QuizState> emit,
  ) async {
    add(const QuizAnswerRequested());
  }
}
