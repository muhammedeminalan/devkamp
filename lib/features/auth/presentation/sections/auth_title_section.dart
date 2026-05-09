import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:flutter/material.dart';

class AuthTitleSection extends StatelessWidget {
  const AuthTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: context.headlineLarge.copyWith(
              fontWeight: FontWeight.w800,
              color: NeutralColor.neutral900,
            ),
            children: <InlineSpan>[
              TextSpan(text: context.l10n.authBrandPrefix),
              TextSpan(
                text: context.l10n.authBrandSuffix,
                style: const TextStyle(color: PrimaryColor.primary600),
              ),
            ],
          ),
        ),
        28.h,
        Text(
          '${context.l10n.authHeadlineLine1}\n${context.l10n.authHeadlineLine2}',
          textAlign: TextAlign.center,
          style: context.headlineSmall.copyWith(
            fontSize: 30,
            height: 1.15,
            fontWeight: FontWeight.w800,
            color: NeutralColor.neutral900,
            letterSpacing: -0.8,
          ),
        ),
        12.h,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            context.l10n.authDescription,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              fontSize: 15,
              height: 1.5,
              color: NeutralColor.neutral600,
            ),
          ),
        ),
      ],
    );
  }
}
