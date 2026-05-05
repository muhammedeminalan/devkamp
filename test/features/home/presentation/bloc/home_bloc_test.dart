import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:app/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:app/features/home/domain/usecases/get_progress_usecase.dart';
import 'package:app/features/home/presentation/bloc/home_bloc.dart';
import 'package:app/features/home/presentation/bloc/home_event.dart';
import 'package:app/features/home/presentation/bloc/home_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}

class MockGetProgressUseCase extends Mock implements GetProgressUseCase {}

final List<Category> _testCategories = <Category>[
  Category(
    id: 'flutter',
    title: 'Flutter',
    questionCount: 10,
    colorValue: Colors.blue.value,
    iconPath: 'assets/icons/flutter.svg',
  ),
];

const LearningProgress _testProgress = LearningProgress(
  completedQuestions: 5,
  totalQuestions: 10,
  streakDays: 3,
  lastStudiedCategory: 'Flutter',
);

void main() {
  late MockGetCategoriesUseCase mockGetCategories;
  late MockGetProgressUseCase mockGetProgress;

  setUp(() {
    mockGetCategories = MockGetCategoriesUseCase();
    mockGetProgress = MockGetProgressUseCase();
  });

  HomeBloc buildBloc() => HomeBloc(
        getCategoriesUseCase: mockGetCategories,
        getProgressUseCase: mockGetProgress,
      );

  group('HomeBloc —', () {
    blocTest<HomeBloc, HomeState>(
      'HomeDataLoaded başarılıysa kategori ve ilerleme verisi emitler',
      build: () {
        when(
          () => mockGetCategories(),
        ).thenAnswer((_) async => Success<List<Category>>(_testCategories));
        when(
          () => mockGetProgress(),
        ).thenAnswer((_) async => const Success<LearningProgress>(_testProgress));
        return buildBloc();
      },
      act: (HomeBloc bloc) => bloc.add(const HomeDataLoaded()),
      expect: () => <HomeState>[
        const HomeState(status: HomeStatus.loading),
        HomeState(
          status: HomeStatus.success,
          categories: _testCategories,
          progress: _testProgress,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'HomeDataLoaded başarısız olursa failure durumu emitler',
      build: () {
        when(() => mockGetCategories()).thenAnswer(
          (_) async => const Failure<List<Category>>(
            DataException('Veri yüklenemedi'),
          ),
        );
        when(
          () => mockGetProgress(),
        ).thenAnswer((_) async => const Success<LearningProgress>(_testProgress));
        return buildBloc();
      },
      act: (HomeBloc bloc) => bloc.add(const HomeDataLoaded()),
      expect: () => <HomeState>[
        const HomeState(status: HomeStatus.loading),
        const HomeState(
          status: HomeStatus.failure,
          errorMessage: 'Veri yüklenemedi',
        ),
      ],
    );
  });
}
