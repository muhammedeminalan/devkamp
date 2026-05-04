import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavedEmptyStateSection extends StatelessWidget {
  const SavedEmptyStateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => context.go('/home'),
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimaryColor.primary600,
          foregroundColor: BasicColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        child: Text(
          AppStrings.savedEmptyAction,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: BasicColor.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
