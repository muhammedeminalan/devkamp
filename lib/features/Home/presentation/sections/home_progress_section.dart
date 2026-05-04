import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class HomeProgressSection extends StatelessWidget {
  const HomeProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: BasicColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColor.neutral100),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(17, 24, 39, 0.06),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
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
      ),
    );
  }
}
