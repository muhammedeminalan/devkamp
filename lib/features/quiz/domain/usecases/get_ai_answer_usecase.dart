import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAiAnswerUseCase {
  const GetAiAnswerUseCase(this._repository);

  final QuizRepository _repository;

  Future<Result<String>> call({
    required String questionText,
    required String topic,
    required String categoryId,
  }) =>
      _repository.getAiAnswer(
        questionText: questionText,
        topic: topic,
        categoryId: categoryId,
      );
}
