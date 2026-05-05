import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:app/features/saved/domain/repositories/saved_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSavedQuestionsUseCase {
  const GetSavedQuestionsUseCase(this._repository);

  final SavedRepository _repository;

  Future<Result<List<SavedQuestion>>> call() => _repository.getSavedQuestions();
}
