import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:flutter/material.dart';

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 16,
    this.borderColor = NeutralColor.neutral100,
    this.backgroundColor = BasicColor.white,
    this.boxShadow = const <BoxShadow>[
      BoxShadow(
        color: Color.fromRGBO(17, 24, 39, 0.06),
        blurRadius: 10,
        offset: Offset(0, 2),
      ),
    ],
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final List<BoxShadow> boxShadow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(borderRadius);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: borderColor),
        boxShadow: boxShadow,
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
