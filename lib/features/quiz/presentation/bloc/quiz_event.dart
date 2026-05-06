sealed class QuizEvent {
  const QuizEvent();
}

// Quiz ekranı açıldığında soruları yüklemek için tetiklenir.
class QuizStarted extends QuizEvent {
  const QuizStarted({
    required this.categoryId,
    this.topicId,
    required this.isRandom,
  });
  final String categoryId;
  final String? topicId;
  final bool isRandom;
}

// Kullanıcı "Cevabı Gör" butonuna bastığında AI cevabını yükler.
class QuizAnswerRequested extends QuizEvent {
  const QuizAnswerRequested();
}

// AI cevabı widget animasyonunu tamamladığında stream'i answered durumuna geçirir.
class QuizAnswerStreamComplete extends QuizEvent {
  const QuizAnswerStreamComplete();
}

// Kullanıcının kendi değerlendirmesi: bildi mi, bilmedi mi.
class QuizEvaluated extends QuizEvent {
  const QuizEvaluated({required this.knew});
  final bool knew;
}

// Sonraki soruya geçer; son sorudaysa quiz'i tamamlar.
class QuizNextQuestion extends QuizEvent {
  const QuizNextQuestion();
}

// Sonuç ekranından quiz'i baştan başlatır (sorular tekrar yüklenir).
class QuizRestarted extends QuizEvent {
  const QuizRestarted();
}

// Soruyu bookmark'lar veya bookmark'ı kaldırır.
class QuizQuestionBookmarked extends QuizEvent {
  const QuizQuestionBookmarked();
}

// AI cevabı yüklenirken hata oluşunca tekrar dener.
class QuizAnswerRetried extends QuizEvent {
  const QuizAnswerRetried();
}
