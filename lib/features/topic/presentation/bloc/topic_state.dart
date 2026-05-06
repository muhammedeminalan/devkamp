import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:equatable/equatable.dart';

enum TopicStatus { initial, loading, success, failure }

class TopicState extends Equatable {
  const TopicState({
    this.status = TopicStatus.initial,
    this.topics = const <Topic>[],
    this.errorMessage,
  });

  final TopicStatus status;
  final List<Topic> topics;
  final String? errorMessage;

  TopicState copyWith({
    TopicStatus? status,
    List<Topic>? topics,
    String? errorMessage,
  }) {
    return TopicState(
      status: status ?? this.status,
      topics: topics ?? this.topics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, topics, errorMessage];
}
