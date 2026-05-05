import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.actionLabel,
    required this.onAction,
    super.key,
    this.title,
    this.subtitle,
  });

  final String? title;
  final String? subtitle;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final bool hasTitle = title != null && title!.isNotEmpty;
    final bool hasSubtitle = subtitle != null && subtitle!.isNotEmpty;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (hasTitle)
            Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: NeutralColor.neutral900,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
          if (hasSubtitle) const SizedBox(height: 6),
          if (hasSubtitle)
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: NeutralColor.neutral500,
                  ),
              textAlign: TextAlign.center,
            ),
          if (hasTitle || hasSubtitle) const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColor.primary600,
              foregroundColor: BasicColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: Text(
              actionLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: BasicColor.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
