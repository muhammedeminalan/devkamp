sealed class SavedEvent {
  const SavedEvent();
}

// Saved ekranı açıldığında mevcut kayıtları çekmek için tetiklenir.
class SavedQuestionsLoaded extends SavedEvent {
  const SavedQuestionsLoaded();
}

// Kullanıcı bir kaydı sildiğinde listeyi güncellemek için kullanılır.
class SavedQuestionRemoved extends SavedEvent {
  const SavedQuestionRemoved(this.questionId);

  final String questionId;
}
