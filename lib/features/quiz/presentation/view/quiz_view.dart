import 'package:app/features/quiz/domain/usecases/get_ai_answer_usecase.dart';
import 'package:app/features/quiz/domain/usecases/get_quiz_questions_usecase.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:app/features/quiz/presentation/sections/question_card_section.dart';
import 'package:app/features/quiz/presentation/sections/question_eval_section.dart';
import 'package:app/features/quiz/presentation/sections/question_progress_section.dart';
import 'package:app/features/quiz/presentation/sections/quiz_result_actions_section.dart';
import 'package:app/features/quiz/presentation/sections/result_breakdown_section.dart';
import 'package:app/features/quiz/presentation/sections/result_score_section.dart';
import 'package:app/core/widgets/states/app_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class QuizView extends StatelessWidget {
  const QuizView({
    required this.categoryId,
    required this.topicName,
    required this.isRandom,
    this.topicId,
    super.key,
  });

  final String categoryId;
  final String? topicId;
  final String topicName;
  final bool isRandom;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (_) => QuizBloc(
        getQuizQuestionsUseCase: GetIt.instance<GetQuizQuestionsUseCase>(),
        getAiAnswerUseCase: GetIt.instance<GetAiAnswerUseCase>(),
      )..add(_quizStartedEvent(categoryId, topicId, isRandom)),
      child: _QuizBody(
        categoryId: categoryId,
        topicId: topicId,
        topicName: topicName,
        isRandom: isRandom,
      ),
    );
  }

  QuizStarted _quizStartedEvent(
    String categoryId,
    String? topicId,
    bool isRandom,
  ) {
    return QuizStarted(
      categoryId: categoryId,
      isRandom: isRandom,
      topicId: topicId,
    );
  }
}

class _QuizBody extends StatelessWidget {
  const _QuizBody({
    required this.categoryId,
    required this.topicName,
    required this.isRandom,
    this.topicId,
  });

  final String categoryId;
  final String? topicId;
  final String topicName;
  final bool isRandom;

  QuizStarted _quizStartedEvent() {
    return QuizStarted(
      categoryId: categoryId,
      isRandom: isRandom,
      topicId: topicId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (BuildContext context, QuizState state) {
            if (state.status == QuizStatus.loading ||
                state.status == QuizStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == QuizStatus.failure) {
              return AppErrorState(
                message: state.errorMessage ?? 'Quiz yüklenemedi.',
                actionLabel: 'Tekrar Dene',
                onAction: () =>
                    context.read<QuizBloc>().add(_quizStartedEvent()),
              );
            }

            if (state.status == QuizStatus.complete) {
              return _QuizResultSection(state: state);
            }

            final question = state.currentQuestion;
            if (question == null) {
              return AppErrorState(
                message: 'Soru bulunamadı.',
                actionLabel: 'Başa Dön',
                onAction: () => context.pop(),
              );
            }

            return _QuizQuestionSection(
              state: state,
              topicName: topicName,
            );
          },
        ),
      ),
    );
  }
}

class _QuizQuestionSection extends StatelessWidget {
  const _QuizQuestionSection({
    required this.state,
    required this.topicName,
  });

  final QuizState state;
  final String topicName;

  @override
  Widget build(BuildContext context) {
    final question = state.currentQuestion;
    if (question == null) {
      return const SizedBox.shrink();
    }
    return Column(
      children: <Widget>[
        QuestionProgressSection(
          currentIndex: state.currentIndex,
          total: state.totalQuestions,
          isBookmarked: state.isBookmarked,
          onBack: () => context.pop(),
          onBookmark: () =>
              context.read<QuizBloc>().add(const QuizQuestionBookmarked()),
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              topicName,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 28),
            child: Column(
              children: <Widget>[
                QuestionCardSection(
                  question: question,
                  answerStage: state.answerStage,
                  answerText: state.answerText,
                  onShowAnswer: () =>
                      context.read<QuizBloc>().add(const QuizAnswerRequested()),
                  onRetry: () =>
                      context.read<QuizBloc>().add(const QuizAnswerRetried()),
                  onStreamingDone: () => context
                      .read<QuizBloc>()
                      .add(const QuizAnswerStreamComplete()),
                ),
                QuestionEvalSection(
                  evalResult: state.evalResult,
                  onKnew: () =>
                      context.read<QuizBloc>().add(const QuizEvaluated(knew: true)),
                  onMissed: () => context
                      .read<QuizBloc>()
                      .add(const QuizEvaluated(knew: false)),
                  onNext: () =>
                      context.read<QuizBloc>().add(const QuizNextQuestion()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QuizResultSection extends StatelessWidget {
  const _QuizResultSection({required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        children: <Widget>[
          ResultScoreSection(
            score: state.knewIndices.length,
            total: state.totalQuestions,
          ),
          const SizedBox(height: 20),
          ResultBreakdownSection(
            knewTopics: state.knewTopics,
            missedTopics: state.missedTopics,
          ),
          const SizedBox(height: 16),
          QuizResultActionsSection(
            onRetry: () => context.read<QuizBloc>().add(const QuizRestarted()),
            onBack: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
