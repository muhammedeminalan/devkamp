import 'package:app/core/constants/assets/app_lottie_paths.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:flutter/material.dart';

class SplashDotLoader extends StatelessWidget {
  const SplashDotLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppLottiePaths.splashDotLoader.lottieAsset(
        width: 42,
        height: 14,
      ),
    );
  }
}
