import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:flutter/material.dart';

class AppCategoryCard extends StatelessWidget {
  const AppCategoryCard({
    required this.title,
    required this.solvedCount,
    required this.totalCount,
    required this.progress,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    this.onTap,
    super.key,
  });

  final String title;
  final int solvedCount;
  final int totalCount;
  final double progress;
  final Widget icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final int progressPercent = (progress * 100).round();

    return AppSurfaceCard(
      margin: const EdgeInsets.all(1),
      borderRadius: 18,
      borderColor: NeutralColor.neutral100,
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color.fromRGBO(17, 24, 39, 0.06),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          color: Color.fromRGBO(17, 24, 39, 0.03),
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: IconTheme(
                  data: IconThemeData(color: iconColor, size: 18),
                  child: icon,
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 3.5,
                      backgroundColor: NeutralColor.neutral200,
                      valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                    ),
                    Text(
                      '$progressPercent%',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: iconColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 8,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: NeutralColor.neutral900,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            '$solvedCount/$totalCount ${context.l10n.profileStatsQuestionSuffix}',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: NeutralColor.neutral500,
                  fontSize: 11.5,
                ),
          ),
        ],
      ),
    );
  }
}
