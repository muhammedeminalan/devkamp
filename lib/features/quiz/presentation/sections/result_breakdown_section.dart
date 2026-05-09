import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class ResultBreakdownSection extends StatelessWidget {
  const ResultBreakdownSection({
    required this.knewTopics,
    required this.missedTopics,
    super.key,
  });

  final List<String> knewTopics;
  final List<String> missedTopics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: NeutralColor.neutral200),
      ),
      child: Column(
        children: <Widget>[
          _BreakdownRow(
            icon: Icons.check_rounded,
            iconBg: const Color(0xFF10B981),
            label: AppStrings.quizResultKnew,
            topics: knewTopics,
            tappable: false,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _BreakdownRow(
            icon: Icons.close_rounded,
            iconBg: const Color(0xFFEF4444),
            label: AppStrings.quizResultMissed,
            topics: missedTopics,
            tappable: true,
          ),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.icon,
    required this.iconBg,
    required this.label,
    required this.topics,
    required this.tappable,
  });

  final IconData icon;
  final Color iconBg;
  final String label;
  final List<String> topics;
  final bool tappable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 12),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Spacer(),
            Text(
              '${topics.length} soru',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: NeutralColor.neutral500,
                  ),
            ),
          ],
        ),
        if (topics.isNotEmpty) ...<Widget>[
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: topics.map((String t) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: tappable
                      ? const Color(0xFFEEF2FF)
                      : NeutralColor.neutral100,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: tappable
                        ? const Color(0xFFC7D2FE)
                        : Colors.transparent,
                  ),
                ),
                child: Text(
                  t,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: tappable
                            ? const Color(0xFF4338CA)
                            : NeutralColor.neutral700,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
