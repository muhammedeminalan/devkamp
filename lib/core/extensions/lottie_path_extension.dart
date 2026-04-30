import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

extension LottiePathExtension on String {
  LottieBuilder lottieAsset({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    bool repeat = true,
    bool animate = true,
    FrameRate? frameRate,
    LottieDelegates? delegates,
  }) {
    return Lottie.asset(
      this,
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      animate: animate,
      frameRate: frameRate,
      delegates: delegates,
    );
  }
}
