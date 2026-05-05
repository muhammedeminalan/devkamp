import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:flutter/material.dart';

class HomeProgressSection extends StatelessWidget {
  const HomeProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppSurfaceCard(
      padding: EdgeInsets.all(14),
      child: _ProgressContent(),
    );
  }
}

class _ProgressContent extends StatelessWidget {
  const _ProgressContent();

  @override
  Widget build(BuildContext context) {
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
                    '5',
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
                      AppStrings.homeXpProgress,
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
              AppStrings.homeXpToNext,
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
          child: const LinearProgressIndicator(
            value: 2140 / 3000,
            minHeight: 8,
            backgroundColor: NeutralColor.neutral100,
            valueColor: AlwaysStoppedAnimation<Color>(PrimaryColor.primary600),
          ),
        ),
      ],
    );
  }
}
