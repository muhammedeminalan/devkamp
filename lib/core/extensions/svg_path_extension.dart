import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension SvgPathExtension on String {
  SvgPicture svgAsset({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
  }) {
    final ColorFilter? colorFilter = color == null
        ? null
        : ColorFilter.mode(color, colorBlendMode);

    return SvgPicture.asset(
      this,
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
    );
  }
}
