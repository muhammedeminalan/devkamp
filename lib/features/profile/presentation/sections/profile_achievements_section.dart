import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/sections/app_section_header.dart';
import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:flutter/material.dart';

class ProfileAchievementsSection extends StatelessWidget {
  const ProfileAchievementsSection({
    required this.achievements,
    super.key,
  });

  final List<Achievement> achievements;

  Color _resolveColor(int index) {
    const List<Color> palette = <Color>[
      Color(0xFFF59E0B),
      Color(0xFF10B981),
      Color(0xFF4F46E5),
      Color(0xFF8B5CF6),
      Color(0xFFEC4899),
    ];
    return palette[index % palette.length];
  }

  String _resolveEmoji(int index) {
    const List<String> emojis = <String>['🔥', '✅', '⚡', '🧠', '🏆'];
    return emojis[index % emojis.length];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const AppSectionHeader(title: AppStrings.profileAchievementsTitle),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: achievements.asMap().entries.map((entry) {
              final int index = entry.key;
              final Achievement badge = entry.value;

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _AchievementBadge(
                  emoji: _resolveEmoji(index),
                  label: badge.title,
                  sub: badge.description,
                  color: _resolveColor(index),
                  locked: !badge.isUnlocked,
                ),
              );
            }).toList(growable: false),
          ),
        ),
      ],
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  const _AchievementBadge({
    required this.emoji,
    required this.label,
    required this.sub,
    required this.color,
    required this.locked,
  });

  final String emoji;
  final String label;
  final String sub;
  final Color color;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: locked ? 0.55 : 1,
      child: Container(
        width: 96,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: locked ? const Color(0xFFF3F4F6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: locked
              ? const <BoxShadow>[]
              : const <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(17, 24, 39, 0.06),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: locked
                    ? const Color(0xFFE5E7EB)
                    : color.withValues(alpha: 0.13),
                border: Border.all(
                  color: locked ? const Color(0xFFD1D5DB) : color,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: NeutralColor.neutral900,
                  ),
            ),
            const SizedBox(height: 1),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    color: NeutralColor.neutral500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
