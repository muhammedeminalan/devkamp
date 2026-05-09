import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class QuizResultActionsSection extends StatelessWidget {
  const QuizResultActionsSection({
    required this.onRetry,
    required this.onBack,
    super.key,
  });

  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onRetry,
            child: const Text(AppStrings.quizResultRetry),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onBack,
            child: const Text(AppStrings.quizResultBack),
          ),
        ),
      ],
    );
  }
}
