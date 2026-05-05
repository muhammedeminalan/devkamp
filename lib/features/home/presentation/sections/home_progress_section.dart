import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:flutter/material.dart';

class HomeProgressSection extends StatelessWidget {
  const HomeProgressSection({
    required this.progress,
    super.key,
  });

  final LearningProgress progress;

  double get _progressValue {
    if (progress.totalQuestions <= 0) {
      return 0;
    }
    final double value = progress.completedQuestions / progress.totalQuestions;
    if (value > 1) {
      return 1;
    }
    if (value < 0) {
      return 0;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(14),
      child: _ProgressContent(
        progress: progress,
        progressValue: _progressValue,
      ),
    );
  }
}

class _ProgressContent extends StatelessWidget {
  const _ProgressContent({
    required this.progress,
    required this.progressValue,
  });

  final LearningProgress progress;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    final int nextTarget = progress.totalQuestions;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        PrimaryColor.primary500,
                        PrimaryColor.primary600,
                        PrimaryColor.primary700,
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${progress.streakDays}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: BasicColor.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppStrings.homeLevelTitle,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: NeutralColor.neutral900,
                          ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '${progress.completedQuestions}/${progress.totalQuestions} soru',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: NeutralColor.neutral500,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '$nextTarget hedef',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: NeutralColor.neutral500,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progressValue,
            minHeight: 8,
            backgroundColor: NeutralColor.neutral100,
            valueColor: const AlwaysStoppedAnimation<Color>(PrimaryColor.primary600),
          ),
        ),
      ],
    );
  }
}
