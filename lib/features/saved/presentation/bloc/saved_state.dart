import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:equatable/equatable.dart';

enum SavedStatus { initial, loading, success, failure }

class SavedState extends Equatable {
  const SavedState({
    this.status = SavedStatus.initial,
    this.questions = const <SavedQuestion>[],
    this.selectedFilterId = 'all',
    this.errorMessage,
  });

  final SavedStatus status;
  final List<SavedQuestion> questions;

  // Seçili kategori filtresi; 'all' tüm soruları gösterir.
  final String selectedFilterId;
  final String? errorMessage;

  // Filtrelenmiş liste; View'da setState yerine buradan okunur.
  List<SavedQuestion> get filteredQuestions {
    if (selectedFilterId == 'all') return questions;
    return questions
        .where((SavedQuestion q) => q.categoryId == selectedFilterId)
        .toList();
  }

  SavedState copyWith({
    SavedStatus? status,
    List<SavedQuestion>? questions,
    String? selectedFilterId,
    String? errorMessage,
  }) {
    return SavedState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      selectedFilterId: selectedFilterId ?? this.selectedFilterId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, questions, selectedFilterId, errorMessage];
}
