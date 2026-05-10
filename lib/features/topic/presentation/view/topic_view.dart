import 'package:app/config/router/app_router.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:app/features/topic/domain/usecases/get_topics_usecase.dart';
import 'package:app/features/topic/presentation/bloc/topic_bloc.dart';
import 'package:app/features/topic/presentation/bloc/topic_event.dart';
import 'package:app/features/topic/presentation/bloc/topic_state.dart';
import 'package:app/features/topic/presentation/sections/topic_filter_chips_section.dart';
import 'package:app/features/topic/presentation/sections/topic_header_section.dart';
import 'package:app/features/topic/presentation/sections/topic_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class TopicView extends StatelessWidget {
  const TopicView({
    required this.categoryId,
    required this.categoryTitle,
    super.key,
  });

  final String categoryId;
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopicBloc>(
      create: (_) => TopicBloc(
        getTopicsUseCase: GetIt.instance<GetTopicsUseCase>(),
      )..add(TopicDataLoaded(categoryId: categoryId)),
      child: _TopicBody(
        categoryId: categoryId,
        categoryTitle: categoryTitle,
      ),
    );
  }
}

class _TopicBody extends StatefulWidget {
  const _TopicBody({
    required this.categoryId,
    required this.categoryTitle,
  });

  final String categoryId;
  final String categoryTitle;

  @override
  State<_TopicBody> createState() => _TopicBodyState();
}

class _TopicBodyState extends State<_TopicBody> {
  TopicDifficulty? _selectedFilter;

  List<Topic> _applyFilter(List<Topic> topics) {
    if (_selectedFilter == null) return topics;
    return topics.where((Topic t) => t.difficulty == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<TopicBloc, TopicState>(
        builder: (BuildContext context, TopicState state) {
          if (state.status == TopicStatus.loading ||
              state.status == TopicStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == TopicStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? 'Konular yüklenemedi.'),
            );
          }

          final List<Topic> filtered = _applyFilter(state.topics);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopicHeaderSection(
                categoryTitle: widget.categoryTitle,
                topics: state.topics,
              ),
              const SizedBox(height: 16),
              TopicFilterChipsSection(
                selected: _selectedFilter,
                onSelected: (TopicDifficulty? diff) =>
                    setState(() => _selectedFilter = diff),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: TopicListSection(
                    topics: filtered,
                    onTopicTap: (Topic topic) => context.push(
                      AppRouter.quizPath,
                      extra: <String, dynamic>{
                        'categoryId': widget.categoryId,
                        'topicId': topic.id,
                        'topicName': topic.name,
                        'isRandom': false,
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          AppRouter.quizPath,
          extra: <String, dynamic>{
            'categoryId': widget.categoryId,
            'topicId': null,
            'topicName': 'Rastgele Quiz Başlat',
            'isRandom': true,
          },
        ),
        backgroundColor: PrimaryColor.primary600,
        icon: const Icon(Icons.bolt_rounded, color: Colors.white),
        label: const Text(
          'Rastgele Quiz Başlat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
