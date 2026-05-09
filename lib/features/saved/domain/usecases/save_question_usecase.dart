import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/repositories/saved_repository.dart';
import 'package:injectable/injectable.dart';

// Kullanıcının bookmark'ladığı soruyu Firestore'a kaydetmek için kullanılır.
@lazySingleton
class SaveQuestionUseCase {
  const SaveQuestionUseCase(this._repository);

  final SavedRepository _repository;

  Future<Result<void>> call({
    required String questionId,
    required String questionText,
    required String categoryId,
    required String categoryTitle,
  }) =>
      _repository.saveQuestion(
        questionId: questionId,
        questionText: questionText,
        categoryId: categoryId,
        categoryTitle: categoryTitle,
      );
}
