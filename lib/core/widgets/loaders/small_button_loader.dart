import 'package:flutter/material.dart';

class SmallButtonLoader extends StatelessWidget {
  const SmallButtonLoader({
    super.key,
    this.size = 18,
    this.strokeWidth = 2,
  });

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(strokeWidth: strokeWidth),
    );
  }
}
