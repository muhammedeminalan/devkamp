import 'package:app/features/Saved/presentation/model/saved_question_ui_model.dart';
import 'package:app/features/Saved/presentation/sections/saved_empty_state_section.dart';
import 'package:app/features/Saved/presentation/sections/saved_filter_chips_section.dart';
import 'package:app/features/Saved/presentation/sections/saved_header_section.dart';
import 'package:app/features/Saved/presentation/sections/saved_question_list_section.dart';
import 'package:flutter/material.dart';

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  String _selectedFilterId = 'all';

  final List<SavedQuestionUiModel> _allQuestions = <SavedQuestionUiModel>[
    const SavedQuestionUiModel(
      id: 'saved_1',
      question: 'Flutter\'da BLoC ile Riverpod arasındaki fark nedir?',
      categoryId: 'flutter',
      categoryLabel: 'FLUTTER',
      difficulty: SavedDifficulty.medium,
      icon: Icons.flutter_dash_rounded,
      iconColor: Color(0xFF2563EB),
      iconBackgroundColor: Color(0xFFDBEAFE),
    ),
    const SavedQuestionUiModel(
      id: 'saved_2',
      question:
          'Python\'da GIL, threading ve multiprocessing\'i nasıl etkiler?',
      categoryId: 'python',
      categoryLabel: 'PYTHON',
      difficulty: SavedDifficulty.easy,
      icon: Icons.code_rounded,
      iconColor: Color(0xFF4F46E5),
      iconBackgroundColor: Color(0xFFEEF2FF),
    ),
    const SavedQuestionUiModel(
      id: 'saved_3',
      question:
          'INNER JOIN, LEFT JOIN ve FULL OUTER JOIN farkını örnekle açıkla.',
      categoryId: 'sql',
      categoryLabel: 'SQL',
      difficulty: SavedDifficulty.medium,
      icon: Icons.storage_rounded,
      iconColor: Color(0xFF0EA5E9),
      iconBackgroundColor: Color(0xFFE0F2FE),
    ),
    const SavedQuestionUiModel(
      id: 'saved_4',
      question:
          'Swift\'te ARC belleği nasıl yönetir ve retain cycle\'a ne sebep olur?',
      categoryId: 'ios',
      categoryLabel: 'IOS',
      difficulty: SavedDifficulty.hard,
      icon: Icons.phone_iphone_rounded,
      iconColor: Color(0xFF16A34A),
      iconBackgroundColor: Color(0xFFDCFCE7),
    ),
    const SavedQuestionUiModel(
      id: 'saved_5',
      question:
          'Günde 100M yeni URL\'ye ölçeklenebilen bir URL kısaltıcı tasarla.',
      categoryId: 'sysd',
      categoryLabel: 'SYSTEM DESIGN',
      difficulty: SavedDifficulty.hard,
      icon: Icons.account_tree_rounded,
      iconColor: Color(0xFF9333EA),
      iconBackgroundColor: Color(0xFFF3E8FF),
    ),
    const SavedQuestionUiModel(
      id: 'saved_6',
      question: 'Stateful ve Stateless widget arasındaki farkı açıkla.',
      categoryId: 'flutter',
      categoryLabel: 'FLUTTER',
      difficulty: SavedDifficulty.easy,
      icon: Icons.flutter_dash_rounded,
      iconColor: Color(0xFF2563EB),
      iconBackgroundColor: Color(0xFFDBEAFE),
    ),
  ];

  List<SavedQuestionUiModel> get _filteredQuestions {
    if (_selectedFilterId == 'all') {
      return _allQuestions;
    }
    return _allQuestions
        .where(
            (SavedQuestionUiModel item) => item.categoryId == _selectedFilterId)
        .toList();
  }

  void _removeSavedQuestion(String id) {
    setState(() {
      _allQuestions.removeWhere((SavedQuestionUiModel item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<SavedQuestionUiModel> filteredQuestions = _filteredQuestions;
    final bool isEmptyState = filteredQuestions.isEmpty;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SavedHeaderSection(totalCount: _allQuestions.length),
              const SizedBox(height: 12),
              SavedFilterChipsSection(
                selectedFilterId: _selectedFilterId,
                onFilterSelected: (String id) {
                  setState(() {
                    _selectedFilterId = id;
                  });
                },
              ),
              const SizedBox(height: 12),
              if (isEmptyState)
                const Expanded(
                  child: Center(
                    child: SavedEmptyStateSection(),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: SavedQuestionListSection(
                      questions: filteredQuestions,
                      onRemove: _removeSavedQuestion,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
