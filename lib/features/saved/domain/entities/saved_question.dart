import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_question.freezed.dart';

// Kaydedilen soruları immutable yapıda taşıyarak silme/filtre akışında tutarlılık sağlar.
@freezed
abstract class SavedQuestion with _$SavedQuestion {
  const factory SavedQuestion({
    required String id,
    // Firestore'daki orijinal soru ID'si; AI cevabı çekmek için gerekli.
    required String questionId,
    required String questionText,
    required String categoryId,
    required String categoryTitle,
    required DateTime savedAt,
  }) = _SavedQuestion;
}
