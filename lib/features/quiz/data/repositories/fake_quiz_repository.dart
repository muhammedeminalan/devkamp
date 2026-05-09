import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:app/features/quiz/domain/repositories/quiz_repository.dart';

// Geliştirme sırasında Firestore olmadan çalışmak için kullanılır.
// DI bağlaması FirestoreQuizRepository'e taşındı.
class FakeQuizRepository implements QuizRepository {
  static const List<QuizQuestion> _allQuestions = <QuizQuestion>[
    QuizQuestion(
      id: 'q1',
      text: 'BLoC ve Riverpod arasındaki temel farklar nelerdir?',
      topic: 'State Management',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q2',
      text: "StatefulWidget ile StatelessWidget'ın farkını açıkla.",
      topic: 'Widget Temelleri',
      difficulty: QuestionDifficulty.easy,
    ),
    QuizQuestion(
      id: 'q3',
      text: "Flutter'da Future ve Stream arasındaki fark nedir?",
      topic: 'Async / Streams',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q4',
      text: 'BuildContext nedir ve neden önemlidir?',
      topic: 'Widget Temelleri',
      difficulty: QuestionDifficulty.easy,
    ),
    QuizQuestion(
      id: 'q5',
      text: "GoRouter'da ShellRoute ne işe yarar?",
      topic: 'Navigation & Routing',
      difficulty: QuestionDifficulty.hard,
    ),
  ];

  @override
  Future<Result<List<QuizQuestion>>> getQuestions({
    required String categoryId,
    required bool isRandom,
    String? topicId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    final List<QuizQuestion> questions = List<QuizQuestion>.from(_allQuestions);
    if (isRandom) questions.shuffle();
    return Success(questions);
  }

  @override
  Future<Result<String>> getAiAnswer({
    required String questionId,
    required String questionText,
    required String topic,
    required String categoryId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return const Success('Bu bir örnek cevaptır. Gerçek cevap Firestore/Gemini\'den gelir.');
  }

  @override
  Future<Result<void>> generateQuestions({
    required String categoryId,
    required String topicId,
    required String topicName,
    required String categoryName,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return const Success(null);
  }
}
