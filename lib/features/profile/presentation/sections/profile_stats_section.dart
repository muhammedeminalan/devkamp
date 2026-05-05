import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/warning_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';
import 'package:flutter/material.dart';

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({
    required this.stats,
    super.key,
  });

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    final int bestStreak = (stats.streakDays * 4.2).round();

    return Row(
      children: <Widget>[
        Expanded(
          child: _ProfileStatCard(
            label: AppStrings.profileStatsTotal,
            value: '${stats.totalSolved}',
            suffix: AppStrings.profileStatsQuestionSuffix,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ProfileStatCard(
            label: AppStrings.profileStatsStreak,
            value: '${stats.streakDays}',
            suffix: AppStrings.profileStatsDaySuffix,
            hot: true,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ProfileStatCard(
            label: AppStrings.profileStatsBest,
            value: '$bestStreak',
            suffix: AppStrings.profileStatsDaySuffix,
          ),
        ),
      ],
    );
  }
}

class _ProfileStatCard extends StatelessWidget {
  const _ProfileStatCard({
    required this.label,
    required this.value,
    required this.suffix,
    this.hot = false,
  });

  final String label;
  final String value;
  final String suffix;
  final bool hot;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(12),
      boxShadow: const <BoxShadow>[],
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: NeutralColor.neutral500,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (hot)
                const Icon(
                  Icons.local_fire_department_rounded,
                  size: 16,
                  color: WarningColor.warning600,
                ),
              if (hot) const SizedBox(width: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color:
                          hot ? WarningColor.warning700 : NeutralColor.neutral900,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            suffix,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: NeutralColor.neutral400,
                ),
          ),
        ],
      ),
    );
  }
}
