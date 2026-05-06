import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_question.freezed.dart';

enum QuestionDifficulty { easy, medium, hard }

// Bir mülakat sorusunu topic ve zorluk bilgisiyle birlikte taşımak için kullanılır.
@freezed
abstract class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String id,
    required String text,
    required String topic,
    required QuestionDifficulty difficulty,
  }) = _QuizQuestion;
}
