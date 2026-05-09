import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';

// Quiz veri kaynağını soyutlayarak domain katmanını implementasyon detaylarından ayırır.
abstract interface class QuizRepository {
  Future<Result<List<QuizQuestion>>> getQuestions({
    required String categoryId,
    required bool isRandom,
    String? topicId,
  });

  // questionId: Firestore cache için gerekli; fake repoda boş geçilebilir.
  Future<Result<String>> getAiAnswer({
    required String questionId,
    required String questionText,
    required String topic,
    required String categoryId,
  });

  // AI ile soru üretir ve Firestore'a kaydeder.
  Future<Result<void>> generateQuestions({
    required String categoryId,
    required String topicId,
    required String topicName,
    required String categoryName,
  });
}
