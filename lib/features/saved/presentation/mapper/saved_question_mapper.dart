import 'package:app/core/constants/category_ids.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:app/features/saved/presentation/model/saved_question_ui_model.dart';
import 'package:flutter/material.dart';

/// Domain entity'yi UI modeline dönüştürür.
/// View ve Bloc dışında bağımsız tutulur; test edilmesi kolaylaşır.
abstract final class SavedQuestionMapper {
  const SavedQuestionMapper._();

  static SavedQuestionUiModel toUiModel(SavedQuestion item) {
    // Zorluk: kategori bazlı basit mantık.
    final SavedDifficulty difficulty = switch (item.categoryId) {
      CategoryIds.flutter || CategoryIds.dart => SavedDifficulty.medium,
      CategoryIds.python                      => SavedDifficulty.easy,
      _                                       => SavedDifficulty.hard,
    };

    final IconData icon = switch (item.categoryId) {
      CategoryIds.flutter => Icons.flutter_dash_rounded,
      CategoryIds.dart    => Icons.code_rounded,
      CategoryIds.python  => Icons.terminal_rounded,
      CategoryIds.ios     => Icons.apple_rounded,
      _                   => Icons.bookmark_rounded,
    };

    final Color iconColor = switch (item.categoryId) {
      CategoryIds.flutter => const Color(0xFF2563EB),
      CategoryIds.dart    => const Color(0xFF4F46E5),
      CategoryIds.python  => const Color(0xFF059669),
      CategoryIds.ios     => const Color(0xFF374151),
      _                   => const Color(0xFF0EA5E9),
    };

    final Color iconBackgroundColor = switch (item.categoryId) {
      CategoryIds.flutter => const Color(0xFFDBEAFE),
      CategoryIds.dart    => const Color(0xFFEEF2FF),
      CategoryIds.python  => const Color(0xFFD1FAE5),
      CategoryIds.ios     => const Color(0xFFF3F4F6),
      _                   => const Color(0xFFE0F2FE),
    };

    return SavedQuestionUiModel(
      id: item.id,
      questionId: item.questionId,
      question: item.questionText,
      categoryId: item.categoryId,
      categoryLabel: item.categoryTitle.toUpperCase(),
      difficulty: difficulty,
      icon: icon,
      iconColor: iconColor,
      iconBackgroundColor: iconBackgroundColor,
    );
  }
}
