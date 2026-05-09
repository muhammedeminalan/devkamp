import 'package:app/core/constants/assets/app_svg_paths.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:app/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/material.dart';

// Artık FirestoreHomeRepository kullanılıyor. Bu sınıf yalnızca referans olarak tutulur.
class FakeHomeRepository implements HomeRepository {
  @override
  Future<Result<List<Category>>> getCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return Success(<Category>[
      Category(
        id: 'flutter',
        title: 'Flutter',
        questionCount: 42,
        colorValue: Colors.blue.toARGB32(),
        iconPath: AppSvgPaths.flutterIcon,
      ),
      Category(
        id: 'dart',
        title: 'Dart',
        questionCount: 35,
        colorValue: Colors.indigo.toARGB32(),
        iconPath: AppSvgPaths.dartIcon,
      ),
      Category(
        id: 'android',
        title: 'Android',
        questionCount: 28,
        colorValue: Colors.green.toARGB32(),
        iconPath: AppSvgPaths.androidIcon,
      ),
    ]);
  }

  @override
  Future<Result<LearningProgress>> getProgress() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    return const Success(
      LearningProgress(
        completedQuestions: 24,
        totalQuestions: 105,
        streakDays: 5,
        lastStudiedCategory: 'Flutter',
      ),
    );
  }
}
