import 'package:flutter/material.dart';

enum SavedDifficulty { easy, medium, hard }

class SavedQuestionUiModel {
  const SavedQuestionUiModel({
    required this.id,
    required this.questionId,
    required this.question,
    required this.categoryId,
    required this.categoryLabel,
    required this.difficulty,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  // Firestore doküman ID'si (silme işlemi için)
  final String id;
  // Orijinal soru ID'si (AI cevabı çekmek için)
  final String questionId;
  final String question;
  final String categoryId;
  final String categoryLabel;
  final SavedDifficulty difficulty;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
}
