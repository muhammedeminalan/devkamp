import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class SavedHeaderSection extends StatelessWidget {
  const SavedHeaderSection({required this.totalCount, super.key});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.savedTitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
                color: NeutralColor.neutral900,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          '$totalCount ${AppStrings.savedReviewCountSuffix}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: NeutralColor.neutral500,
              ),
        ),
      ],
    );
  }
}
