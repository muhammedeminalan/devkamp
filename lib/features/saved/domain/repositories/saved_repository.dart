import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';

abstract interface class SavedRepository {
  Future<Result<List<SavedQuestion>>> getSavedQuestions();
  Future<Result<void>> removeQuestion(String questionId);
}
