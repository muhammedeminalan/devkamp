import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:app/features/saved/domain/usecases/get_saved_questions_usecase.dart';
import 'package:app/features/saved/domain/usecases/remove_saved_question_usecase.dart';
import 'package:app/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:app/features/saved/presentation/bloc/saved_event.dart';
import 'package:app/features/saved/presentation/bloc/saved_state.dart';
import 'package:app/features/saved/presentation/model/saved_question_ui_model.dart';
import 'package:app/features/saved/presentation/sections/saved_empty_state_section.dart';
import 'package:app/features/saved/presentation/sections/saved_filter_chips_section.dart';
import 'package:app/features/saved/presentation/sections/saved_header_section.dart';
import 'package:app/features/saved/presentation/sections/saved_question_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  String _selectedFilterId = 'all';

  List<SavedQuestion> _filterQuestions(List<SavedQuestion> questions) {
    if (_selectedFilterId == 'all') {
      return questions;
    }

    return questions
        .where((SavedQuestion item) => item.categoryId == _selectedFilterId)
        .toList();
  }

  SavedQuestionUiModel _mapToUiModel(SavedQuestion item) {
    final SavedDifficulty difficulty = switch (item.categoryId) {
      'flutter' => SavedDifficulty.medium,
      'dart' => SavedDifficulty.easy,
      _ => SavedDifficulty.hard,
    };

    final IconData icon = switch (item.categoryId) {
      'flutter' => Icons.flutter_dash_rounded,
      'dart' => Icons.code_rounded,
      _ => Icons.bookmark_rounded,
    };

    final Color iconColor = switch (item.categoryId) {
      'flutter' => const Color(0xFF2563EB),
      'dart' => const Color(0xFF4F46E5),
      _ => const Color(0xFF0EA5E9),
    };

    final Color iconBackgroundColor = switch (item.categoryId) {
      'flutter' => const Color(0xFFDBEAFE),
      'dart' => const Color(0xFFEEF2FF),
      _ => const Color(0xFFE0F2FE),
    };

    return SavedQuestionUiModel(
      id: item.id,
      question: item.questionText,
      categoryId: item.categoryId,
      categoryLabel: item.categoryTitle.toUpperCase(),
      difficulty: difficulty,
      icon: icon,
      iconColor: iconColor,
      iconBackgroundColor: iconBackgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavedBloc>(
      create: (BuildContext context) => SavedBloc(
        getSavedQuestionsUseCase: GetIt.instance<GetSavedQuestionsUseCase>(),
        removeSavedQuestionUseCase:
            GetIt.instance<RemoveSavedQuestionUseCase>(),
      )..add(const SavedQuestionsLoaded()),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: BlocBuilder<SavedBloc, SavedState>(
              builder: (BuildContext context, SavedState state) {
                if (state.status == SavedStatus.loading ||
                    state.status == SavedStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == SavedStatus.failure) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Kayıtlı sorular yüklenemedi.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final List<SavedQuestion> filteredQuestions =
                    _filterQuestions(state.questions);
                final bool isEmptyState = filteredQuestions.isEmpty;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SavedHeaderSection(totalCount: state.questions.length),
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
                            questions: filteredQuestions
                                .map(_mapToUiModel)
                                .toList(growable: false),
                            onRemove: (String id) {
                              context
                                  .read<SavedBloc>()
                                  .add(SavedQuestionRemoved(id));
                            },
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
