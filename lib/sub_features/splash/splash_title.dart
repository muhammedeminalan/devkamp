import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:flutter/material.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: context.displaySmall.copyWith(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.6,
              color: NeutralColor.neutral900,
            ),
            children: const <InlineSpan>[
              TextSpan(text: AppStrings.splashBrandPrefix),
              TextSpan(
                text: AppStrings.splashBrandSuffix,
                style: TextStyle(color: PrimaryColor.primary600),
              ),
            ],
          ),
        ),
        10.h,
        AppStrings.splashSubtitle
            .text
            .bodyLarge(context)
            .medium
            .fontSize(16)
            .color(NeutralColor.neutral600)
            .alignCenter,
      ],
    );
  }
}
