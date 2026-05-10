import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/core/result/result.dart';
import 'package:app/core/widgets/app_markdown_body.dart';
import 'package:app/features/quiz/domain/usecases/get_ai_answer_usecase.dart';
import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:app/features/saved/domain/usecases/get_saved_questions_usecase.dart';
import 'package:app/features/saved/domain/usecases/remove_saved_question_usecase.dart';
import 'package:app/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:app/features/saved/presentation/bloc/saved_event.dart';
import 'package:app/features/saved/presentation/bloc/saved_state.dart';
import 'package:app/features/saved/presentation/mapper/saved_question_mapper.dart';
import 'package:app/features/saved/presentation/model/saved_question_ui_model.dart';
import 'package:app/features/saved/presentation/sections/saved_empty_state_section.dart';
import 'package:app/features/saved/presentation/sections/saved_filter_chips_section.dart';
import 'package:app/features/saved/presentation/sections/saved_header_section.dart';
import 'package:app/features/saved/presentation/sections/saved_question_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  // Kaydedilen soruya tıklanınca soru + AI cevabını bottom sheet'te göster.
  void _showAnswerSheet(BuildContext context, SavedQuestionUiModel item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.92,
        expand: false,
        builder: (_, ScrollController scrollController) =>
            _SavedAnswerSheet(item: item, scrollController: scrollController),
      ),
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

                // filteredQuestions SavedState.getter'ından gelir; setState gerekmez.
                final List<SavedQuestion> filtered = state.filteredQuestions;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SavedHeaderSection(totalCount: state.questions.length),
                    const SizedBox(height: 12),
                    SavedFilterChipsSection(
                      questions: state.questions,
                      selectedFilterId: state.selectedFilterId,
                      onFilterSelected: (String id) =>
                          context.read<SavedBloc>().add(SavedFilterChanged(id)),
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
                                .map(SavedQuestionMapper.toUiModel)
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
  const _SavedAnswerSheet({
    required this.item,
    required this.scrollController,
  });

  final SavedQuestionUiModel item;
  final ScrollController scrollController;

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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: <Widget>[
          // Tutma çubuğu — aşağı sürükleyerek kapatılır
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
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController,
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
                        context.l10n.savedAiAnswer,
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
                    AppMarkdownBody(text: _answer ?? ''),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
