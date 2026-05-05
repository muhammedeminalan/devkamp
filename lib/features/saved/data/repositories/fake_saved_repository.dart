import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:app/features/saved/domain/repositories/saved_repository.dart';

// Backend hazır olana kadar kayıtlı soru akışını in-memory yürütmek için kullanılır.
class FakeSavedRepository implements SavedRepository {
  final List<SavedQuestion> _questions = <SavedQuestion>[
    SavedQuestion(
      id: 'q1',
      questionText: 'Flutter\'da StatelessWidget ne zaman kullanılır?',
      categoryId: 'flutter',
      categoryTitle: 'Flutter',
      savedAt: DateTime(2026, 5, 1),
    ),
    SavedQuestion(
      id: 'q2',
      questionText: 'Dart\'ta async/await nasıl çalışır?',
      categoryId: 'dart',
      categoryTitle: 'Dart',
      savedAt: DateTime(2026, 4, 28),
    ),
    SavedQuestion(
      id: 'q3',
      questionText: 'BLoC pattern\'ın avantajları nelerdir?',
      categoryId: 'flutter',
      categoryTitle: 'Flutter',
      savedAt: DateTime(2026, 4, 25),
    ),
  ];

  @override
  Future<Result<List<SavedQuestion>>> getSavedQuestions() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return Success(List<SavedQuestion>.unmodifiable(_questions));
  }

  @override
  Future<Result<void>> removeQuestion(String questionId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _questions.removeWhere((SavedQuestion q) => q.id == questionId);
    return const Success<void>(null);
  }
}
