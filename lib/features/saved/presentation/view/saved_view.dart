import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/usecases/get_ai_answer_usecase.dart';
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
    if (_selectedFilterId == 'all') return questions;
    return questions
        .where((SavedQuestion q) => q.categoryId == _selectedFilterId)
        .toList();
  }

  SavedQuestionUiModel _mapToUiModel(SavedQuestion item) {
    // Zorluk: soru sayısı veya kategori bazlı basit mantık.
    final SavedDifficulty difficulty = switch (item.categoryId) {
      'flutter' || 'dart' => SavedDifficulty.medium,
      'python' => SavedDifficulty.easy,
      _ => SavedDifficulty.hard,
    };

    final IconData icon = switch (item.categoryId) {
      'flutter' => Icons.flutter_dash_rounded,
      'dart'    => Icons.code_rounded,
      'python'  => Icons.terminal_rounded,
      'ios'     => Icons.apple_rounded,
      _         => Icons.bookmark_rounded,
    };

    final Color iconColor = switch (item.categoryId) {
      'flutter' => const Color(0xFF2563EB),
      'dart'    => const Color(0xFF4F46E5),
      'python'  => const Color(0xFF059669),
      'ios'     => const Color(0xFF374151),
      _         => const Color(0xFF0EA5E9),
    };

    final Color iconBackgroundColor = switch (item.categoryId) {
      'flutter' => const Color(0xFFDBEAFE),
      'dart'    => const Color(0xFFEEF2FF),
      'python'  => const Color(0xFFD1FAE5),
      'ios'     => const Color(0xFFF3F4F6),
      _         => const Color(0xFFE0F2FE),
    };

    return SavedQuestionUiModel(
      id: item.id,
      questionId: item.questionId,
      question: item.questionText,
      categoryId: item.categoryId,
      categoryLabel: item.categoryTitle.toUpperCase(),
      difficulty: difficulty,
      icon: icon,
      iconColor: iconColor,
      iconBackgroundColor: iconBackgroundColor,
    );
  }

  // Kaydedilen soruya tıklanınca soru + AI cevabını bottom sheet'te göster.
  void _showAnswerSheet(BuildContext context, SavedQuestionUiModel item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SavedAnswerSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavedBloc>(
      create: (BuildContext context) => SavedBloc(
        getSavedQuestionsUseCase: GetIt.instance<GetSavedQuestionsUseCase>(),
        removeSavedQuestionUseCase: GetIt.instance<RemoveSavedQuestionUseCase>(),
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

                final List<SavedQuestion> filtered =
                    _filterQuestions(state.questions);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SavedHeaderSection(totalCount: state.questions.length),
                    const SizedBox(height: 12),
                    SavedFilterChipsSection(
                      questions: state.questions,
                      selectedFilterId: _selectedFilterId,
                      onFilterSelected: (String id) =>
                          setState(() => _selectedFilterId = id),
                    ),
                    const SizedBox(height: 12),
                    if (filtered.isEmpty)
                      const Expanded(
                        child: Center(child: SavedEmptyStateSection()),
                      )
                    else
                      Expanded(
                        child: SingleChildScrollView(
                          child: SavedQuestionListSection(
                            questions: filtered
                                .map(_mapToUiModel)
                                .toList(growable: false),
                            onRemove: (String id) =>
                                context.read<SavedBloc>().add(SavedQuestionRemoved(id)),
                            onTap: (SavedQuestionUiModel item) =>
                                _showAnswerSheet(context, item),
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

// Kaydedilen sorunun AI cevabını bottom sheet içinde gösterir.
class _SavedAnswerSheet extends StatefulWidget {
  const _SavedAnswerSheet({required this.item});

  final SavedQuestionUiModel item;

  @override
  State<_SavedAnswerSheet> createState() => _SavedAnswerSheetState();
}

class _SavedAnswerSheetState extends State<_SavedAnswerSheet> {
  late final GetAiAnswerUseCase _getAiAnswer;
  String? _answer;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getAiAnswer = GetIt.instance<GetAiAnswerUseCase>();
    _fetchAnswer();
  }

  Future<void> _fetchAnswer() async {
    final result = await _getAiAnswer(
      questionId: widget.item.questionId,
      questionText: widget.item.question,
      topic: widget.item.categoryId,
      categoryId: widget.item.categoryId,
    );

    if (!mounted) return;

    switch (result) {
      case Success<String>():
        setState(() {
          _answer = result.data;
          _loading = false;
        });
      case Failure<String>():
        setState(() {
          _error = result.exception.message;
          _loading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.85;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Tutma çubuğu
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: NeutralColor.neutral200,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Kategori etiketi
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.item.iconBackgroundColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      widget.item.categoryLabel,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: widget.item.iconColor,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Soru metni
                  Text(
                    widget.item.question,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                        ),
                  ),
                  const SizedBox(height: 20),
                  // Ayırıcı
                  const Divider(),
                  const SizedBox(height: 16),
                  // Cevap bölümü
                  Row(
                    children: <Widget>[
                      const Icon(Icons.auto_awesome_rounded,
                          size: 16, color: PrimaryColor.primary600),
                      const SizedBox(width: 6),
                      Text(
                        'AI Cevabı',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: PrimaryColor.primary600,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_loading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (_error != null)
                    Text(
                      'Cevap yüklenemedi: $_error',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                          ),
                    )
                  else
                    Text(
                      _answer ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                            color: NeutralColor.neutral700,
                          ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
