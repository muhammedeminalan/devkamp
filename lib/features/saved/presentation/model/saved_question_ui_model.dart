import 'package:flutter/material.dart';

enum SavedDifficulty { easy, medium, hard }

class SavedQuestionUiModel {
  const SavedQuestionUiModel({
    required this.id,
    required this.question,
    required this.categoryId,
    required this.categoryLabel,
    required this.difficulty,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  final String id;
  final String question;
  final String categoryId;
  final String categoryLabel;
  final SavedDifficulty difficulty;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
}
