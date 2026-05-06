import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:flutter/material.dart';

class TopicFilterChipsSection extends StatelessWidget {
  const TopicFilterChipsSection({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final TopicDifficulty? selected; // null = Tümü
  final ValueChanged<TopicDifficulty?> onSelected;

  static const List<(String, TopicDifficulty?)> _filters =
      <(String, TopicDifficulty?)>[
    ('Tümü', null),
    ('Başlangıç', TopicDifficulty.easy),
    ('Orta', TopicDifficulty.medium),
    ('İleri', TopicDifficulty.hard),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final (String label, TopicDifficulty? diff) = _filters[index];
          final bool isActive = selected == diff;

          return GestureDetector(
            onTap: () => onSelected(diff),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isActive ? PrimaryColor.primary600 : Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isActive
                      ? PrimaryColor.primary600
                      : NeutralColor.neutral200,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isActive
                          ? Colors.white
                          : NeutralColor.neutral600,
                      fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.w500,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
