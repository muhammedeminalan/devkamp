import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:app/features/quiz/domain/repositories/quiz_repository.dart';

// Firebase AI aktif edildiği için artık yalnızca soru listesi için kullanılır.
// DI bağlaması FirebaseQuizRepository'e taşındı.
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
      text: 'StatefulWidget ile StatelessWidget\'ın farkını açıkla.',
      topic: 'Widget Temelleri',
      difficulty: QuestionDifficulty.easy,
    ),
    QuizQuestion(
      id: 'q3',
      text: 'Flutter\'da Future ve Stream arasındaki fark nedir?',
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
      text: 'GoRouter\'da ShellRoute ne işe yarar?',
      topic: 'Navigation & Routing',
      difficulty: QuestionDifficulty.hard,
    ),
    QuizQuestion(
      id: 'q6',
      text: 'Widget key\'leri ne zaman ve neden kullanmalısın?',
      topic: 'Widget Temelleri',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q7',
      text: 'get_it ve injectable birlikte nasıl çalışır?',
      topic: 'Dependency Injection',
      difficulty: QuestionDifficulty.hard,
    ),
    QuizQuestion(
      id: 'q8',
      text: 'Dart\'ta extension method ne zaman tercih edilmeli?',
      topic: 'Dart Özellikleri',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q9',
      text:
          'Flutter\'da performans optimizasyonu için const constructor neden önemlidir?',
      topic: 'Performans',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q10',
      text: 'Isolate nedir ve ne zaman kullanılmalıdır?',
      topic: 'Async / Streams',
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
    if (isRandom) {
      questions.shuffle();
    }

    return Success(questions.take(10).toList());
  }

  @override
  Future<Result<String>> getAiAnswer({
    required String questionText,
    required String topic,
    required String categoryId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    // Fake implementasyonda sabit cevap döner; gerçek yanıt FirebaseQuizRepository'den gelir.
    return const Success(
      'Bu bir örnek cevaptır. Gerçek cevap için Firebase AI kullanılır.',
    );
  }
}
