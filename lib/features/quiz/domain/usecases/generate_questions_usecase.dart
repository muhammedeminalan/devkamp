import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GenerateQuestionsUseCase {
  const GenerateQuestionsUseCase(this._repository);

  final QuizRepository _repository;

  Future<Result<void>> call({
    required String categoryId,
    required String topicId,
    required String topicName,
    required String categoryName,
  }) =>
      _repository.generateQuestions(
        categoryId: categoryId,
        topicId: topicId,
        topicName: topicName,
        categoryName: categoryName,
      );
}
