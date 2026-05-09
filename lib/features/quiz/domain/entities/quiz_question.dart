import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_question.freezed.dart';

enum QuestionDifficulty { easy, medium, hard }

// Cevap Firestore'da cache'lendiğinde durumunu takip etmek için kullanılır.
enum AnswerStatus { none, generating, ready }

// Bir mülakat sorusunu ve opsiyonel AI cevabını taşır.
// categoryId ve order Firestore'daki dokümanla eşleşmek için eklendi.
@freezed
abstract class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String id,
    required String text,
    required String topic,
    required QuestionDifficulty difficulty,
    @Default('') String categoryId,
    @Default(0) int order,
    String? answer,
    @Default(AnswerStatus.none) AnswerStatus answerStatus,
  }) = _QuizQuestion;
}
