import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';

// Quiz veri kaynağını soyutlayarak domain katmanını implementasyon detaylarından ayırır.
abstract interface class QuizRepository {
  Future<Result<List<QuizQuestion>>> getQuestions({
    required String categoryId,
    required bool isRandom,
    String? topicId,
  });

  Future<Result<String>> getAiAnswer({
    required String questionText,
    required String topic,
    required String categoryId,
  });
}
