import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning_progress.freezed.dart';

// Kullanıcının home ekranındaki ilerleme özetini tek modelde toplamak için kullanılır.
@freezed
abstract class LearningProgress with _$LearningProgress {
  const factory LearningProgress({
    required int completedQuestions,
    required int totalQuestions,
    required int streakDays,
    required String lastStudiedCategory,
  }) = _LearningProgress;
}
