import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class ProfileAchievementsSection extends StatelessWidget {
  const ProfileAchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<({String emoji, String label, String sub, Color color, bool locked})>
        badges = <({String emoji, String label, String sub, Color color, bool locked})>[
      (emoji: '🔥', label: 'Ateşli', sub: '5 günlük seri', color: const Color(0xFFF59E0B), locked: false),
      (emoji: '✅', label: 'Yüzbaşı', sub: '100 soru', color: const Color(0xFF10B981), locked: false),
      (emoji: '⚡', label: 'Hızlı Çeken', sub: '<30sn ort.', color: const Color(0xFF4F46E5), locked: false),
      (emoji: '🧠', label: 'Çok Dilli', sub: '3 dil', color: const Color(0xFF8B5CF6), locked: true),
      (emoji: '🏆', label: 'Şampiyon', sub: 'İlk %10', color: const Color(0xFFEC4899), locked: true),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.profileAchievementsTitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: NeutralColor.neutral900,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: badges.map((badge) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _AchievementBadge(
                  emoji: badge.emoji,
                  label: badge.label,
                  sub: badge.sub,
                  color: badge.color,
                  locked: badge.locked,
                ),
              );
            }).toList(),
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
                color: locked ? const Color(0xFFE5E7EB) : color.withValues(alpha: 0.13),
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
