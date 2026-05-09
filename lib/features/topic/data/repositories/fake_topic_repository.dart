import 'package:app/core/result/result.dart';
import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:app/features/topic/domain/repositories/topic_repository.dart';

// Artık FirestoreTopicRepository kullanılıyor. Bu sınıf yalnızca referans olarak tutulur.
class FakeTopicRepository implements TopicRepository {
  static const List<Topic> _flutterTopics = <Topic>[
    Topic(id: 'widgets', name: 'Widget Temelleri', difficulty: TopicDifficulty.easy, questionCount: 8, isDone: true),
    Topic(id: 'state', name: 'State Management', difficulty: TopicDifficulty.medium, questionCount: 12, isDone: true),
    Topic(id: 'bloc', name: 'BLoC Pattern', difficulty: TopicDifficulty.medium, questionCount: 10, isDone: false),
    Topic(id: 'navigation', name: 'Navigation & Routing', difficulty: TopicDifficulty.medium, questionCount: 7, isDone: false),
    Topic(id: 'async', name: 'Async / Streams', difficulty: TopicDifficulty.hard, questionCount: 9, isDone: false),
    Topic(id: 'di', name: 'Dependency Injection', difficulty: TopicDifficulty.hard, questionCount: 6, isDone: false),
    Topic(id: 'testing', name: 'Widget Testing', difficulty: TopicDifficulty.hard, questionCount: 8, isDone: false),
  ];

  static const List<Topic> _dartTopics = <Topic>[
    Topic(id: 'null-safety', name: 'Null Safety', difficulty: TopicDifficulty.easy, questionCount: 6, isDone: true),
    Topic(id: 'generics', name: 'Generics', difficulty: TopicDifficulty.medium, questionCount: 8, isDone: false),
    Topic(id: 'isolates', name: 'Isolates', difficulty: TopicDifficulty.hard, questionCount: 7, isDone: false),
    Topic(id: 'extensions', name: 'Extensions', difficulty: TopicDifficulty.medium, questionCount: 5, isDone: false),
  ];

  static const List<Topic> _androidTopics = <Topic>[
    Topic(id: 'platform-channels', name: 'Platform Channels', difficulty: TopicDifficulty.hard, questionCount: 6, isDone: false),
    Topic(id: 'permissions', name: 'İzin Yönetimi', difficulty: TopicDifficulty.easy, questionCount: 5, isDone: false),
    Topic(id: 'notifications', name: 'Bildirimler', difficulty: TopicDifficulty.medium, questionCount: 7, isDone: false),
  ];

  @override
  Future<Result<List<Topic>>> getTopics({required String categoryId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final List<Topic> topics = switch (categoryId) {
      'flutter' => _flutterTopics,
      'dart' => _dartTopics,
      'android' => _androidTopics,
      _ => _flutterTopics,
    };

    return Success(topics);
  }
}
