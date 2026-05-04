import 'package:flutter/material.dart';

class HomeCategoryUiModel {
  const HomeCategoryUiModel({
    required this.title,
    required this.solvedCount,
    required this.totalCount,
    required this.progress,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  final String title;
  final int solvedCount;
  final int totalCount;
  final double progress;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
}
