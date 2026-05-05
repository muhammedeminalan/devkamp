import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/repositories/saved_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RemoveSavedQuestionUseCase {
  const RemoveSavedQuestionUseCase(this._repository);

  final SavedRepository _repository;

  Future<Result<void>> call(String questionId) =>
      _repository.removeQuestion(questionId);
}
