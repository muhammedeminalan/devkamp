import 'dart:developer' as dev;

import 'package:app/core/result/result.dart';
import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:app/features/topic/domain/usecases/get_topics_usecase.dart';
import 'package:app/features/topic/presentation/bloc/topic_event.dart';
import 'package:app/features/topic/presentation/bloc/topic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TopicBloc extends Bloc<TopicEvent, TopicState> {
  TopicBloc({required GetTopicsUseCase getTopicsUseCase})
      : _getTopics = getTopicsUseCase,
        super(const TopicState()) {
    on<TopicDataLoaded>(_onTopicDataLoaded);
  }

  final GetTopicsUseCase _getTopics;

  Future<void> _onTopicDataLoaded(
    TopicDataLoaded event,
    Emitter<TopicState> emit,
  ) async {
    dev.log('📚 Topic verileri yükleniyor | categoryId: ${event.categoryId}', name: 'TopicBloc');
    emit(state.copyWith(status: TopicStatus.loading));

    final Result<List<Topic>> result =
        await _getTopics(categoryId: event.categoryId);

    switch (result) {
      case Success<List<Topic>>():
        dev.log('✅ Topic verileri hazır | count: ${result.data.length}', name: 'TopicBloc');
        emit(state.copyWith(status: TopicStatus.success, topics: result.data));
      case Failure<List<Topic>>():
        dev.log('❌ Topic yükleme hatası: ${result.exception.message}', name: 'TopicBloc');
        emit(state.copyWith(
          status: TopicStatus.failure,
          errorMessage: result.exception.message,
        ));
    }
  }
}
