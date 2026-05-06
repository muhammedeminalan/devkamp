import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:equatable/equatable.dart';

enum QuizStatus { initial, loading, question, failure, complete }
enum AnswerStage { hidden, loading, streaming, answered, error }
enum EvalResult { none, knew, missed }

class QuizState extends Equatable {
  const QuizState({
    this.status = QuizStatus.initial,
    this.questions = const <QuizQuestion>[],
    this.currentIndex = 0,
    this.answerStage = AnswerStage.hidden,
    this.evalResult = EvalResult.none,
    this.isBookmarked = false,
    this.knewIndices = const <int>{},
    this.missedIndices = const <int>{},
    this.answerText,
    this.errorMessage,
  });

  final QuizStatus status;
  final List<QuizQuestion> questions;
  final int currentIndex;
  final AnswerStage answerStage;
  final EvalResult evalResult;
  final bool isBookmarked;
  final Set<int> knewIndices;
  final Set<int> missedIndices;
  final String? answerText;
  final String? errorMessage;

  QuizQuestion? get currentQuestion =>
      questions.isEmpty ? null : questions[currentIndex];

  int get totalQuestions => questions.length;
  bool get isLastQuestion => currentIndex >= questions.length - 1;

  List<String> get knewTopics =>
      knewIndices.map((int i) => questions[i].topic).toList();
  List<String> get missedTopics =>
      missedIndices.map((int i) => questions[i].topic).toList();

  // Nullable alanları null'a sıfırlamak için sentinel pattern — ?? operatörü null'ı yok sayar.
  static const Object _sentinel = Object();

  QuizState copyWith({
    QuizStatus? status,
    List<QuizQuestion>? questions,
    int? currentIndex,
    AnswerStage? answerStage,
    EvalResult? evalResult,
    bool? isBookmarked,
    Set<int>? knewIndices,
    Set<int>? missedIndices,
    Object? answerText = _sentinel,
    Object? errorMessage = _sentinel,
  }) {
    return QuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      answerStage: answerStage ?? this.answerStage,
      evalResult: evalResult ?? this.evalResult,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      knewIndices: knewIndices ?? this.knewIndices,
      missedIndices: missedIndices ?? this.missedIndices,
      answerText: identical(answerText, _sentinel) ? this.answerText : answerText as String?,
      errorMessage: identical(errorMessage, _sentinel) ? this.errorMessage : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        status,
        questions,
        currentIndex,
        answerStage,
        evalResult,
        isBookmarked,
        knewIndices,
        missedIndices,
        answerText,
        errorMessage,
      ];
}
