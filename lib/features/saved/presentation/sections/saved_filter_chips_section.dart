import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:flutter/material.dart';

class SavedFilterChipsSection extends StatelessWidget {
  const SavedFilterChipsSection({
    required this.questions,
    required this.selectedFilterId,
    required this.onFilterSelected,
    super.key,
  });

  final List<SavedQuestion> questions;
  final String selectedFilterId;
  final ValueChanged<String> onFilterSelected;

  // Kayıtlı sorulardan benzersiz kategorileri çıkar; her zaman "Tümü" başta gelir.
  // context gerektiği için parametre olarak alınır (l10n erişimi).
  List<(String, String)> _buildFilters(BuildContext context) {
    final Map<String, String> seen = <String, String>{};
    for (final SavedQuestion q in questions) {
      if (q.categoryId.isNotEmpty) {
        seen[q.categoryId] = q.categoryTitle;
      }
    }
    return <(String, String)>[
      ('all', context.l10n.savedFilterAll),
      ...seen.entries.map((MapEntry<String, String> e) => (e.key, e.value)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<(String, String)> filters = _buildFilters(context);

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
