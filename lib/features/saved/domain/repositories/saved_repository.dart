import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';

abstract interface class SavedRepository {
  Future<Result<List<SavedQuestion>>> getSavedQuestions();
  Future<Result<void>> saveQuestion({
    required String questionId,
    required String questionText,
    required String categoryId,
    required String categoryTitle,
  });
  Future<Result<void>> removeQuestion(String questionId);
}
