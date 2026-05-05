import 'package:app/core/constants/assets/app_svg_paths.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:flutter/material.dart';

class AuthIllustration extends StatelessWidget {
  const AuthIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: AppSvgPaths.illustrationDevAtDesk.svgAsset(),
    );
  }
}
