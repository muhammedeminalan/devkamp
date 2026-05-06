import 'package:app/core/result/result.dart';
import 'package:app/features/topic/domain/entities/topic.dart';

abstract interface class TopicRepository {
  Future<Result<List<Topic>>> getTopics({required String categoryId});
}
