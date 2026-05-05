import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/assets/app_svg_paths.dart';
import 'package:app/core/constants/ui/padding_values.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:flutter/material.dart';

class SplashLogoCard extends StatelessWidget {
  const SplashLogoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.0698132,
      child: Container(
        width: 104,
        height: 104,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              PrimaryColor.primary500,
              PrimaryColor.primary600,
              PrimaryColor.primary700,
            ],
            stops: <double>[0, 0.6, 1],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: PrimaryColor.primary600.withValues(alpha: 0.45),
              blurRadius: 60,
              offset: const Offset(0, 22),
            ),
          ],
        ),
        child: Padding(
          padding: PaddingValues.largePadding.all,
          child: AppSvgPaths.devKampLogo.svgAsset(),
        ),
      ),
    );
  }
}
