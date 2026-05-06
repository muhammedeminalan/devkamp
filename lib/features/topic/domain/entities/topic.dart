import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.freezed.dart';

enum TopicDifficulty { easy, medium, hard }

@freezed
abstract class Topic with _$Topic {
  const factory Topic({
    required String id,
    required String name,
    required TopicDifficulty difficulty,
    required int questionCount,
    required bool isDone,
  }) = _Topic;
}
