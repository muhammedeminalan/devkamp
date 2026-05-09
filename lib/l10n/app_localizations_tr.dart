// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'DevKamp';

  @override
  String get splashBrandPrefix => 'Dev';

  @override
  String get splashBrandSuffix => 'Kamp';

  @override
  String get splashSubtitle => 'Bir profesyonel gibi mülakata gir.';

  @override
  String get authBrandPrefix => 'Dev';

  @override
  String get authBrandSuffix => 'Kamp';

  @override
  String get authHeadlineLine1 => 'Yazılım kariyerinde';

  @override
  String get authHeadlineLine2 => 'bir adım öne geç.';

  @override
  String get authDescription =>
      'Gerçek mülakat sorularını çalış. Anında AI geri bildirimi al.';

  @override
  String get authGoogleContinue => 'Google ile Devam Et';

  @override
  String get authFreeNote => 'Sonsuza dek ücretsiz. Kredi kartı gerekmez.';

  @override
  String get homeFallbackUserName => 'Geliştirici';

  @override
  String get homeContinueSectionTitle => 'Kaldığın yerden devam et';

  @override
  String get homeContinueButton => 'Devam Et';

  @override
  String get homeCategoriesTitle => 'Kategoriler';

  @override
  String get homeSeeAll => 'Tümünü gör';

  @override
  String get homeAllCategoriesTitle => 'Tüm Kategoriler';

  @override
  String get homeAllCategoriesSubtitle => 'Çalışmak istediğin alanı seç';

  @override
  String get homeMorningMotivation => 'Güne iyi bir başlangıç yap 🎯';

  @override
  String get homeAfternoonMotivation => 'Bugün ilk soruyu çöz 💡';

  @override
  String get homeEveningMotivation => 'Geceyi verimli geçir 🌙';

  @override
  String get homeStreakFirst => 'İyi başladın, devam et! 💪';

  @override
  String homeStreakKeep(int count) {
    return '$count günlük serini koru 🔥';
  }

  @override
  String homeStreakMid(int count) {
    return '$count gündür aralıksız çalışıyorsun 🚀';
  }

  @override
  String homeStreakLegend(int count) {
    return '$count günlük efsane seri! 👑';
  }

  @override
  String get homeProgressStart => 'Çalışmaya Başla';

  @override
  String get homeProgressFirstDay => 'İlk Gün! 🎯';

  @override
  String homeProgressStreak(int count) {
    return '$count Günlük Seri 🔥';
  }

  @override
  String get homeQuestionsSuffix => 'soru';

  @override
  String get savedTitle => 'Kaydedilen Sorular';

  @override
  String get savedReviewCountSuffix => 'tekrar edilecek soru';

  @override
  String get savedFilterAll => 'Tümü';

  @override
  String get savedDifficultyEasy => 'Kolay';

  @override
  String get savedDifficultyMedium => 'Orta';

  @override
  String get savedDifficultyHard => 'Zor';

  @override
  String get savedEmptyTitle => 'Henüz kaydedilen soru yok';

  @override
  String get savedEmptySubtitle =>
      'Tekrar etmek için soru kaydet — burada görünürler.';

  @override
  String get savedEmptyAction => 'Keşfetmeye başla';

  @override
  String get savedAiAnswer => 'AI Cevabı';

  @override
  String get categoryRetry => 'Tekrar Dene';

  @override
  String get categoryNotFound => 'Kategori bulunamadı.';

  @override
  String get categoryRandomQuiz => 'Rastgele Quiz';

  @override
  String get categoryListLoading => 'Sorular hazırlanıyor...';

  @override
  String get categoryListLoadingHint => 'İlk açılışta sorular oluşturulur';

  @override
  String get categoryGenerating => 'AI kategoriler hazırlanıyor...';

  @override
  String get quizDifficultyEasy => 'Kolay';

  @override
  String get quizDifficultyMedium => 'Orta';

  @override
  String get quizDifficultyHard => 'Zor';

  @override
  String get quizSeeAnswer => 'Cevabı Gör';

  @override
  String get quizAiAnswer => 'AI Cevabı';

  @override
  String get quizAnswerError => 'AI cevabı yüklenemedi.';

  @override
  String get quizAnswerErrorHint => 'Bağlantını kontrol et ve tekrar dene.';

  @override
  String get quizAnswerRetry => 'Tekrar Dene';

  @override
  String get quizEvalKnew => 'Biliyordum';

  @override
  String get quizEvalMissed => 'Bilmiyordum';

  @override
  String get quizNextQuestion => 'Sonraki Soru';

  @override
  String get quizResultRetry => 'Tekrar Çöz';

  @override
  String get quizResultBack => 'Geri Dön';

  @override
  String get quizResultKnew => 'Bildim';

  @override
  String get quizResultMissed => 'Bilmedim';

  @override
  String quizProgressLabel(int current, int total) {
    return 'Soru $current / $total';
  }

  @override
  String quizTopicCount(int count) {
    return '$count soru';
  }

  @override
  String get profileStatsTotal => 'Toplam';

  @override
  String get profileStatsStreak => 'Seri';

  @override
  String get profileStatsBest => 'En İyi';

  @override
  String get profileStatsQuestionSuffix => 'soru';

  @override
  String get profileStatsDaySuffix => 'gün';

  @override
  String get profilePerformanceTitle => 'Kategori Performansı';

  @override
  String get profileAchievementsTitle => 'Başarımlar';

  @override
  String get profileSettingsTitle => 'Ayarlar';

  @override
  String get profileSettingDifficulty => 'Tercih edilen zorluk';

  @override
  String get profileSettingNotifications => 'Bildirimler';

  @override
  String get profileSettingReminder => 'Günlük hatırlatıcı';

  @override
  String get profileReminderTime => '09:00';

  @override
  String get profileSignOut => 'Çıkış Yap';

  @override
  String get profileSettingLanguage => 'Dil';

  @override
  String get profileLanguageSystem => 'Sistem';

  @override
  String get profileLanguageTurkish => 'Türkçe';

  @override
  String get profileLanguageEnglish => 'İngilizce';
}
