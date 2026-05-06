import 'package:app/core/result/result.dart';
import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:app/features/topic/domain/repositories/topic_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTopicsUseCase {
  const GetTopicsUseCase(this._repository);

  final TopicRepository _repository;

  Future<Result<List<Topic>>> call({required String categoryId}) =>
      _repository.getTopics(categoryId: categoryId);
}
