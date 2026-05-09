final class AppStrings {
  const AppStrings._();

  // ── Uygulama geneli ────────────────────────────────────────────────────────
  static const String appName = 'DevKamp';

  // ── Splash ─────────────────────────────────────────────────────────────────
  static const String splashBrandPrefix = 'Dev';
  static const String splashBrandSuffix = 'Kamp';
  static const String splashSubtitle = 'Bir profesyonel gibi mulakata gir.';

  // ── Auth ───────────────────────────────────────────────────────────────────
  static const String authBrandPrefix = 'Dev';
  static const String authBrandSuffix = 'Kamp';
  static const String authHeadlineLine1 = 'Yazılım kariyerinde';
  static const String authHeadlineLine2 = 'bir adım öne geç.';
  static const String authDescription =
      'Gerçek mülakat sorularını çalış. Anında AI geri bildirimi al.';
  static const String authGoogleContinue = 'Google ile Devam Et';
  static const String authFreeNote = 'Sonsuza dek ücretsiz. Kredi kartı gerekmez.';

  // ── Home ───────────────────────────────────────────────────────────────────
  static const String homeFallbackUserName = 'Geliştirici';
  static const String homeContinueSectionTitle = 'Kaldığın yerden devam et';
  static const String homeContinueButton = 'Devam Et';
  static const String homeCategoriesTitle = 'Kategoriler';
  static const String homeSeeAll = 'Tümünü gör';
  static const String homeAllCategoriesTitle = 'Tüm Kategoriler';
  static const String homeAllCategoriesSubtitle = 'Çalışmak istediğin alanı seç';
  // Motivasyon metinleri — saat bazlı (streak == 0)
  static const String homeMorningMotivation = 'Güne iyi bir başlangıç yap 🎯';
  static const String homeAfternoonMotivation = 'Bugün ilk soruyu çöz 💡';
  static const String homeEveningMotivation = 'Geceyi verimli geçir 🌙';
  // Motivasyon metinleri — streak bazlı
  static const String homeStreakFirst = 'İyi başladın, devam et! 💪';
  // Progress section etiketleri
  static const String homeProgressStart = 'Çalışmaya Başla';
  static const String homeProgressFirstDay = 'İlk Gün! 🎯';

  // ── Saved ──────────────────────────────────────────────────────────────────
  static const String savedTitle = 'Kaydedilen Sorular';
  static const String savedReviewCountSuffix = 'tekrar edilecek soru';
  static const String savedFilterAll = 'Tümü';
  static const String savedDifficultyEasy = 'Kolay';
  static const String savedDifficultyMedium = 'Orta';
  static const String savedDifficultyHard = 'Zor';
  static const String savedEmptyTitle = 'Henüz kaydedilen soru yok';
  static const String savedEmptySubtitle =
      'Tekrar etmek için soru kaydet — burada görünürler.';
  static const String savedEmptyAction = 'Keşfetmeye başla';
  static const String savedAiAnswer = 'AI Cevabı';

  // ── Category ───────────────────────────────────────────────────────────────
  static const String categoryRetry = 'Tekrar Dene';
  static const String categoryNotFound = 'Kategori bulunamadı.';
  static const String categoryRandomQuiz = 'Rastgele Quiz';
  static const String categoryListLoading = 'Sorular hazırlanıyor...';
  static const String categoryListLoadingHint = 'İlk açılışta sorular oluşturulur';
  static const String categoryGenerating = 'AI kategoriler hazırlanıyor...';

  // ── Quiz ───────────────────────────────────────────────────────────────────
  static const String quizDifficultyEasy = 'Kolay';
  static const String quizDifficultyMedium = 'Orta';
  static const String quizDifficultyHard = 'Zor';
  static const String quizSeeAnswer = 'Cevabı Gör';
  static const String quizAiAnswer = 'AI Cevabı';
  static const String quizAnswerError = 'AI cevabı yüklenemedi.';
  static const String quizAnswerErrorHint = 'Bağlantını kontrol et ve tekrar dene.';
  static const String quizAnswerRetry = 'Tekrar Dene';
  static const String quizEvalKnew = 'Biliyordum';
  static const String quizEvalMissed = 'Bilmiyordum';
  static const String quizNextQuestion = 'Sonraki Soru';
  static const String quizResultRetry = 'Tekrar Çöz';
  static const String quizResultBack = 'Geri Dön';
  static const String quizResultKnew = 'Bildim';
  static const String quizResultMissed = 'Bilmedim';

  // ── Profile ────────────────────────────────────────────────────────────────
  static const String profileStatsTotal = 'Toplam';
  static const String profileStatsStreak = 'Seri';
  static const String profileStatsBest = 'En İyi';
  static const String profileStatsQuestionSuffix = 'soru';
  static const String profileStatsDaySuffix = 'gün';
  static const String profilePerformanceTitle = 'Kategori Performansı';
  static const String profileAchievementsTitle = 'Başarımlar';
  static const String profileSettingsTitle = 'Ayarlar';
  static const String profileSettingDifficulty = 'Tercih edilen zorluk';
  static const String profileSettingNotifications = 'Bildirimler';
  static const String profileSettingReminder = 'Günlük hatırlatıcı';
  static const String profileReminderTime = '09:00';
  static const String profileSignOut = 'Çıkış Yap';
}
