import 'package:flutter/material.dart';

class AppScoreRing extends StatelessWidget {
  const AppScoreRing({
    required this.score,
    required this.total,
    required this.ringColor,
    super.key,
    this.size = 170,
    this.strokeWidth = 14,
    this.backgroundColor = const Color(0xFFE5E7EB),
  });

  final int score;
  final int total;
  final double size;
  final double strokeWidth;
  final Color ringColor;
  final Color backgroundColor;

  double get _progress {
    if (total <= 0) {
      return 0;
    }
    final double ratio = score / total;
    if (ratio <= 0) {
      return 0;
    }
    if (ratio >= 1) {
      return 0.999;
    }
    return ratio;
  }

  int get _percentage {
    if (total <= 0) {
      return 0;
    }
    return ((score / total) * 100).round().clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _progress),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (BuildContext context, double value, Widget? child) {
              return SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.all(strokeWidth / 2),
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: strokeWidth,
                    strokeCap: StrokeCap.round,
                    backgroundColor: backgroundColor,
                    valueColor: AlwaysStoppedAnimation<Color>(ringColor),
                  ),
                ),
              );
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '$score/$total',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
              ),
              Text(
                '$_percentage% doğru',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: ringColor,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
