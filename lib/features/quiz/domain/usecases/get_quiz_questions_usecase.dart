import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetQuizQuestionsUseCase {
  const GetQuizQuestionsUseCase(this._repository);

  final QuizRepository _repository;

  Future<Result<List<QuizQuestion>>> call({
    required String categoryId,
    String? topicId,
    required bool isRandom,
  }) =>
      _repository.getQuestions(
        categoryId: categoryId,
        topicId: topicId,
        isRandom: isRandom,
      );
}
