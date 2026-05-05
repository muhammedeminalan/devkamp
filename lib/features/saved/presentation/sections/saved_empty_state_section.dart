import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/states/app_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavedEmptyStateSection extends StatelessWidget {
  const SavedEmptyStateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      actionLabel: AppStrings.savedEmptyAction,
      onAction: () => context.go('/home'),
    );
  }
}
