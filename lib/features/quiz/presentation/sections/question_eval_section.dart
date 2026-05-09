import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:flutter/material.dart';

class QuestionEvalSection extends StatelessWidget {
  const QuestionEvalSection({
    required this.evalResult,
    required this.onKnew,
    required this.onMissed,
    required this.onNext,
    super.key,
  });

  final EvalResult evalResult;
  final VoidCallback onKnew;
  final VoidCallback onMissed;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _EvalButton(
                  label: context.l10n.quizEvalKnew,
                  icon: Icons.check_rounded,
                  isSelected: evalResult == EvalResult.knew,
                  selectedColor: const Color(0xFF10B981),
                  selectedBg: const Color(0xFFD1FAE5),
                  defaultBg: const Color(0xFFF0FDF4),
                  onTap: onKnew,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _EvalButton(
                  label: context.l10n.quizEvalMissed,
                  icon: Icons.close_rounded,
                  isSelected: evalResult == EvalResult.missed,
                  selectedColor: const Color(0xFFEF4444),
                  selectedBg: const Color(0xFFFEE2E2),
                  defaultBg: const Color(0xFFFFF5F5),
                  onTap: onMissed,
                ),
              ),
            ],
          ),
          if (evalResult != EvalResult.none) ...<Widget>[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onNext,
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: Text(context.l10n.quizNextQuestion),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EvalButton extends StatelessWidget {
  const _EvalButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.selectedColor,
    required this.selectedBg,
    required this.defaultBg,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final Color selectedColor;
  final Color selectedBg;
  final Color defaultBg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color bg = isSelected ? selectedBg : defaultBg;
    final Color fg = isSelected ? selectedColor : const Color(0xFF6B7280);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? selectedColor.withValues(alpha: 0.4)
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: fg, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
