import 'package:app/core/extensions/project_extensions.dart';
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
            child: Text(context.l10n.quizResultRetry),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onBack,
            child: Text(context.l10n.quizResultBack),
          ),
        ),
      ],
    );
  }
}
