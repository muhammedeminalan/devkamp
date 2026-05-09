import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:app/features/saved/presentation/model/saved_question_ui_model.dart';
import 'package:flutter/material.dart';

class SavedQuestionListSection extends StatelessWidget {
  const SavedQuestionListSection({
    required this.questions,
    required this.onRemove,
    required this.onTap,
    super.key,
  });

  final List<SavedQuestionUiModel> questions;
  final ValueChanged<String> onRemove;
  final ValueChanged<SavedQuestionUiModel> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: questions.map((SavedQuestionUiModel item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Dismissible(
            key: ValueKey<String>(item.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => onRemove(item.id),
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: BasicColor.white,
                size: 22,
              ),
            ),
            child: GestureDetector(
              onTap: () => onTap(item),
              child: _SavedQuestionCard(item: item),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SavedQuestionCard extends StatelessWidget {
  const _SavedQuestionCard({required this.item});

  final SavedQuestionUiModel item;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: item.iconBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(item.icon, color: item.iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.question,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: NeutralColor.neutral900,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        item.categoryLabel,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: item.iconColor,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: NeutralColor.neutral300,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    _DifficultyBadge(level: item.difficulty),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.bookmark, color: PrimaryColor.primary600, size: 20),
        ],
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  const _DifficultyBadge({required this.level});

  final SavedDifficulty level;

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color background;
    late final Color foreground;

    switch (level) {
      case SavedDifficulty.easy:
        label = AppStrings.savedDifficultyEasy;
        background = const Color(0xFFD1FAE5);
        foreground = const Color(0xFF047857);
      case SavedDifficulty.medium:
        label = AppStrings.savedDifficultyMedium;
        background = const Color(0xFFFEF3C7);
        foreground = const Color(0xFFB45309);
      case SavedDifficulty.hard:
        label = AppStrings.savedDifficultyHard;
        background = const Color(0xFFFEE2E2);
        foreground = const Color(0xFFB91C1C);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
