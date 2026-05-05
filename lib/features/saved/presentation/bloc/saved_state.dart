import 'package:app/features/saved/domain/entities/saved_question.dart';
import 'package:equatable/equatable.dart';

enum SavedStatus { initial, loading, success, failure }

class SavedState extends Equatable {
  const SavedState({
    this.status = SavedStatus.initial,
    this.questions = const <SavedQuestion>[],
    this.errorMessage,
  });

  final SavedStatus status;
  final List<SavedQuestion> questions;
  final String? errorMessage;

  SavedState copyWith({
    SavedStatus? status,
    List<SavedQuestion>? questions,
    String? errorMessage,
  }) {
    return SavedState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, questions, errorMessage];
}
