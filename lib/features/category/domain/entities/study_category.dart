import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_category.freezed.dart';

enum CategoryStatus { generating, ready, error }

enum QuestionsStatus { none, generating, ready }

// AI'ın bir topic için ürettiği alt kategoriyi (örn. BLoC, OOP) taşır.
@freezed
abstract class StudyCategory with _$StudyCategory {
  const factory StudyCategory({
    required String id,
    required String topicId,
    required String name,
    required CategoryStatus status,
    required QuestionsStatus questionsStatus,
    @Default(0) int questionCount,
    @Default('') String createdBy,
    DateTime? createdAt,
  }) = _StudyCategory;
}
