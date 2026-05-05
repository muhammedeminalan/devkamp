import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1, -1),
          end: Alignment(1, 1),
          stops: <double>[0, 0.3, 0.6, 1],
          colors: <Color>[
            PrimaryColor.primary50,
            PrimaryColor.primary100,
            BasicColor.white,
            PrimaryColor.primary100,
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -80,
            left: -60,
            child: _GlowBlob(
              size: 260,
              color: PrimaryColor.primary500.withValues(alpha: 0.18),
            ),
          ),
          Positioned(
            right: -80,
            bottom: -100,
            child: _GlowBlob(
              size: 320,
              color: PrimaryColor.primary400.withValues(alpha: 0.16),
            ),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            color,
            color.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}
