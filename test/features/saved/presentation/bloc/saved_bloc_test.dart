import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:app/features/saved/domain/usecases/get_saved_questions_usecase.dart';
import 'package:app/features/saved/domain/usecases/remove_saved_question_usecase.dart';
import 'package:app/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:app/features/saved/presentation/bloc/saved_event.dart';
import 'package:app/features/saved/presentation/bloc/saved_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetSavedQuestionsUseCase extends Mock
    implements GetSavedQuestionsUseCase {}

class MockRemoveSavedQuestionUseCase extends Mock
    implements RemoveSavedQuestionUseCase {}

final List<SavedQuestion> _testQuestions = <SavedQuestion>[
  SavedQuestion(
    id: 'q1',
    questionId: 'question_1',
    questionText: 'Soru 1',
    categoryId: 'flutter',
    categoryTitle: 'Flutter',
    savedAt: DateTime(2026, 5, 1),
  ),
];

void main() {
  late MockGetSavedQuestionsUseCase mockGetSavedQuestions;
  late MockRemoveSavedQuestionUseCase mockRemoveSavedQuestion;

  setUp(() {
    mockGetSavedQuestions = MockGetSavedQuestionsUseCase();
    mockRemoveSavedQuestion = MockRemoveSavedQuestionUseCase();
  });

  SavedBloc buildBloc() => SavedBloc(
        getSavedQuestionsUseCase: mockGetSavedQuestions,
        removeSavedQuestionUseCase: mockRemoveSavedQuestion,
      );

  group('SavedBloc —', () {
    blocTest<SavedBloc, SavedState>(
      'SavedQuestionsLoaded başarılıysa listeyi success ile emitler',
      build: () {
        when(() => mockGetSavedQuestions())
            .thenAnswer((_) async => Success<List<SavedQuestion>>(_testQuestions));
        return buildBloc();
      },
      act: (SavedBloc bloc) => bloc.add(const SavedQuestionsLoaded()),
      expect: () => <SavedState>[
        const SavedState(status: SavedStatus.loading),
        SavedState(status: SavedStatus.success, questions: _testQuestions),
      ],
    );

    blocTest<SavedBloc, SavedState>(
      'SavedQuestionsLoaded başarısız olursa failure durumunu emitler',
      build: () {
        when(() => mockGetSavedQuestions()).thenAnswer(
          (_) async => const Failure<List<SavedQuestion>>(
            DataException('Liste alınamadı'),
          ),
        );
        return buildBloc();
      },
      act: (SavedBloc bloc) => bloc.add(const SavedQuestionsLoaded()),
      expect: () => const <SavedState>[
        SavedState(status: SavedStatus.loading),
        SavedState(
          status: SavedStatus.failure,
          errorMessage: 'Liste alınamadı',
        ),
      ],
    );

    blocTest<SavedBloc, SavedState>(
      'SavedQuestionRemoved soruyu anında listeden çıkarır',
      build: () {
        when(() => mockRemoveSavedQuestion('q1'))
            .thenAnswer((_) async => const Success<void>(null));
        return buildBloc();
      },
      seed: () => SavedState(
        status: SavedStatus.success,
        questions: _testQuestions,
      ),
      act: (SavedBloc bloc) => bloc.add(const SavedQuestionRemoved('q1')),
      expect: () => const <SavedState>[
        SavedState(status: SavedStatus.success, questions: <SavedQuestion>[]),
      ],
    );
  });
}
