import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class SavedFilterChipsSection extends StatelessWidget {
  const SavedFilterChipsSection({
    required this.selectedFilterId,
    required this.onFilterSelected,
    super.key,
  });

  final String selectedFilterId;
  final ValueChanged<String> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final List<(String, String)> filters = <(String, String)>[
      ('all', AppStrings.savedFilterAll),
      ('flutter', AppStrings.savedFilterFlutter),
      ('python', AppStrings.savedFilterPython),
      ('ios', AppStrings.savedFilterIos),
      ('sql', AppStrings.savedFilterSql),
      ('sysd', AppStrings.savedFilterSystemDesign),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map(((String, String) filter) {
          final String id = filter.$1;
          final String label = filter.$2;
          final bool selected = selectedFilterId == id;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              selected: selected,
              onSelected: (_) => onFilterSelected(id),
              label: Text(label),
              labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: selected ? Colors.white : PrimaryColor.primary600,
                    fontWeight: FontWeight.w600,
                  ),
              selectedColor: PrimaryColor.primary600,
              backgroundColor: Colors.white,
              side: BorderSide(
                color:
                    selected ? PrimaryColor.primary600 : PrimaryColor.primary100,
              ),
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
