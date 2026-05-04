import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppStrings.homeGreetPrefix,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: NeutralColor.neutral500,
                      fontWeight: FontWeight.w500,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                '$userName 👋',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: NeutralColor.neutral900,
                      letterSpacing: -0.8,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
