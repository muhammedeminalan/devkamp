import 'package:app/core/result/result.dart';
import 'package:app/features/topic/domain/entities/topic.dart';

// Konu listesi verisinin kaynağını soyutlayarak domain katmanını veri katmanından ayırır.
interface class TopicRepository {
  Future<Result<List<Topic>>> getTopics({required String categoryId}) {
    throw UnimplementedError();
  }
}
