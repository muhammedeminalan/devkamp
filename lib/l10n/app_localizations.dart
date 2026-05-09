import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// Uygulama adı
  ///
  /// In tr, this message translates to:
  /// **'DevKamp'**
  String get appName;

  /// Splash logo — 'Dev' kısmı
  ///
  /// In tr, this message translates to:
  /// **'Dev'**
  String get splashBrandPrefix;

  /// Splash logo — 'Kamp' kısmı
  ///
  /// In tr, this message translates to:
  /// **'Kamp'**
  String get splashBrandSuffix;

  /// Splash ekranı alt başlık
  ///
  /// In tr, this message translates to:
  /// **'Bir profesyonel gibi mülakata gir.'**
  String get splashSubtitle;

  /// Auth logo — 'Dev' kısmı
  ///
  /// In tr, this message translates to:
  /// **'Dev'**
  String get authBrandPrefix;

  /// Auth logo — 'Kamp' kısmı
  ///
  /// In tr, this message translates to:
  /// **'Kamp'**
  String get authBrandSuffix;

  /// Auth başlık 1. satır
  ///
  /// In tr, this message translates to:
  /// **'Yazılım kariyerinde'**
  String get authHeadlineLine1;

  /// Auth başlık 2. satır
  ///
  /// In tr, this message translates to:
  /// **'bir adım öne geç.'**
  String get authHeadlineLine2;

  /// Auth açıklama metni
  ///
  /// In tr, this message translates to:
  /// **'Gerçek mülakat sorularını çalış. Anında AI geri bildirimi al.'**
  String get authDescription;

  /// Google giriş butonu
  ///
  /// In tr, this message translates to:
  /// **'Google ile Devam Et'**
  String get authGoogleContinue;

  /// Ücretsiz hizmet notu
  ///
  /// In tr, this message translates to:
  /// **'Sonsuza dek ücretsiz. Kredi kartı gerekmez.'**
  String get authFreeNote;

  /// Kullanıcı adı bilinmiyorsa fallback
  ///
  /// In tr, this message translates to:
  /// **'Geliştirici'**
  String get homeFallbackUserName;

  /// Devam et bölümü başlığı
  ///
  /// In tr, this message translates to:
  /// **'Kaldığın yerden devam et'**
  String get homeContinueSectionTitle;

  /// Devam et butonu
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get homeContinueButton;

  /// Kategoriler bölümü başlığı
  ///
  /// In tr, this message translates to:
  /// **'Kategoriler'**
  String get homeCategoriesTitle;

  /// Tümünü gör linki
  ///
  /// In tr, this message translates to:
  /// **'Tümünü gör'**
  String get homeSeeAll;

  /// Tüm kategoriler sayfası başlığı
  ///
  /// In tr, this message translates to:
  /// **'Tüm Kategoriler'**
  String get homeAllCategoriesTitle;

  /// Tüm kategoriler sayfası alt başlık
  ///
  /// In tr, this message translates to:
  /// **'Çalışmak istediğin alanı seç'**
  String get homeAllCategoriesSubtitle;

  /// Sabah motivasyon mesajı (streak=0)
  ///
  /// In tr, this message translates to:
  /// **'Güne iyi bir başlangıç yap 🎯'**
  String get homeMorningMotivation;

  /// Öğleden sonra motivasyon mesajı (streak=0)
  ///
  /// In tr, this message translates to:
  /// **'Bugün ilk soruyu çöz 💡'**
  String get homeAfternoonMotivation;

  /// Akşam motivasyon mesajı (streak=0)
  ///
  /// In tr, this message translates to:
  /// **'Geceyi verimli geçir 🌙'**
  String get homeEveningMotivation;

  /// Motivasyon — streak=1
  ///
  /// In tr, this message translates to:
  /// **'İyi başladın, devam et! 💪'**
  String get homeStreakFirst;

  /// Motivasyon — streak 2-4
  ///
  /// In tr, this message translates to:
  /// **'{count} günlük serini koru 🔥'**
  String homeStreakKeep(int count);

  /// Motivasyon — streak 5-14
  ///
  /// In tr, this message translates to:
  /// **'{count} gündür aralıksız çalışıyorsun 🚀'**
  String homeStreakMid(int count);

  /// Motivasyon — streak 15+
  ///
  /// In tr, this message translates to:
  /// **'{count} günlük efsane seri! 👑'**
  String homeStreakLegend(int count);

  /// Progress — streak=0
  ///
  /// In tr, this message translates to:
  /// **'Çalışmaya Başla'**
  String get homeProgressStart;

  /// Progress — streak=1
  ///
  /// In tr, this message translates to:
  /// **'İlk Gün! 🎯'**
  String get homeProgressFirstDay;

  /// Progress — streak 2+
  ///
  /// In tr, this message translates to:
  /// **'{count} Günlük Seri 🔥'**
  String homeProgressStreak(int count);

  /// Soru sayısı birimi
  ///
  /// In tr, this message translates to:
  /// **'soru'**
  String get homeQuestionsSuffix;

  /// Kaydedilen sorular sayfa başlığı
  ///
  /// In tr, this message translates to:
  /// **'Kaydedilen Sorular'**
  String get savedTitle;

  /// Tekrar edilecek soru sayısı birimi
  ///
  /// In tr, this message translates to:
  /// **'tekrar edilecek soru'**
  String get savedReviewCountSuffix;

  /// Filtre — tümü
  ///
  /// In tr, this message translates to:
  /// **'Tümü'**
  String get savedFilterAll;

  /// Zorluk seviyesi — kolay
  ///
  /// In tr, this message translates to:
  /// **'Kolay'**
  String get savedDifficultyEasy;

  /// Zorluk seviyesi — orta
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get savedDifficultyMedium;

  /// Zorluk seviyesi — zor
  ///
  /// In tr, this message translates to:
  /// **'Zor'**
  String get savedDifficultyHard;

  /// Boş liste başlığı
  ///
  /// In tr, this message translates to:
  /// **'Henüz kaydedilen soru yok'**
  String get savedEmptyTitle;

  /// Boş liste açıklaması
  ///
  /// In tr, this message translates to:
  /// **'Tekrar etmek için soru kaydet — burada görünürler.'**
  String get savedEmptySubtitle;

  /// Boş liste aksiyon butonu
  ///
  /// In tr, this message translates to:
  /// **'Keşfetmeye başla'**
  String get savedEmptyAction;

  /// AI cevabı başlığı (saved sheet)
  ///
  /// In tr, this message translates to:
  /// **'AI Cevabı'**
  String get savedAiAnswer;

  /// Hata durumunda tekrar dene butonu
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get categoryRetry;

  /// Kategori bulunamadı mesajı
  ///
  /// In tr, this message translates to:
  /// **'Kategori bulunamadı.'**
  String get categoryNotFound;

  /// Rastgele quiz butonu etiketi
  ///
  /// In tr, this message translates to:
  /// **'Rastgele Quiz'**
  String get categoryRandomQuiz;

  /// Sorular üretilirken yükleme etiketi
  ///
  /// In tr, this message translates to:
  /// **'Sorular hazırlanıyor...'**
  String get categoryListLoading;

  /// İlk açılış ipucu
  ///
  /// In tr, this message translates to:
  /// **'İlk açılışta sorular oluşturulur'**
  String get categoryListLoadingHint;

  /// AI kategori üretim mesajı
  ///
  /// In tr, this message translates to:
  /// **'AI kategoriler hazırlanıyor...'**
  String get categoryGenerating;

  /// Quiz zorluk — kolay
  ///
  /// In tr, this message translates to:
  /// **'Kolay'**
  String get quizDifficultyEasy;

  /// Quiz zorluk — orta
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get quizDifficultyMedium;

  /// Quiz zorluk — zor
  ///
  /// In tr, this message translates to:
  /// **'Zor'**
  String get quizDifficultyHard;

  /// Cevabı gör butonu
  ///
  /// In tr, this message translates to:
  /// **'Cevabı Gör'**
  String get quizSeeAnswer;

  /// AI cevabı başlığı
  ///
  /// In tr, this message translates to:
  /// **'AI Cevabı'**
  String get quizAiAnswer;

  /// AI cevap hata mesajı
  ///
  /// In tr, this message translates to:
  /// **'AI cevabı yüklenemedi.'**
  String get quizAnswerError;

  /// AI cevap hata ipucu
  ///
  /// In tr, this message translates to:
  /// **'Bağlantını kontrol et ve tekrar dene.'**
  String get quizAnswerErrorHint;

  /// AI cevap tekrar dene butonu
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get quizAnswerRetry;

  /// Değerlendirme — biliyordum
  ///
  /// In tr, this message translates to:
  /// **'Biliyordum'**
  String get quizEvalKnew;

  /// Değerlendirme — bilmiyordum
  ///
  /// In tr, this message translates to:
  /// **'Bilmiyordum'**
  String get quizEvalMissed;

  /// Sonraki soru butonu
  ///
  /// In tr, this message translates to:
  /// **'Sonraki Soru'**
  String get quizNextQuestion;

  /// Quiz sonuç — tekrar çöz
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Çöz'**
  String get quizResultRetry;

  /// Quiz sonuç — geri dön
  ///
  /// In tr, this message translates to:
  /// **'Geri Dön'**
  String get quizResultBack;

  /// Sonuç özeti — bildim
  ///
  /// In tr, this message translates to:
  /// **'Bildim'**
  String get quizResultKnew;

  /// Sonuç özeti — bilmedim
  ///
  /// In tr, this message translates to:
  /// **'Bilmedim'**
  String get quizResultMissed;

  /// Quiz ilerleme etiketi
  ///
  /// In tr, this message translates to:
  /// **'Soru {current} / {total}'**
  String quizProgressLabel(int current, int total);

  /// Konu soru sayısı
  ///
  /// In tr, this message translates to:
  /// **'{count} soru'**
  String quizTopicCount(int count);

  /// Profil istatistik — toplam
  ///
  /// In tr, this message translates to:
  /// **'Toplam'**
  String get profileStatsTotal;

  /// Profil istatistik — seri
  ///
  /// In tr, this message translates to:
  /// **'Seri'**
  String get profileStatsStreak;

  /// Profil istatistik — en iyi
  ///
  /// In tr, this message translates to:
  /// **'En İyi'**
  String get profileStatsBest;

  /// Soru birimi
  ///
  /// In tr, this message translates to:
  /// **'soru'**
  String get profileStatsQuestionSuffix;

  /// Gün birimi
  ///
  /// In tr, this message translates to:
  /// **'gün'**
  String get profileStatsDaySuffix;

  /// Kategori performansı başlığı
  ///
  /// In tr, this message translates to:
  /// **'Kategori Performansı'**
  String get profilePerformanceTitle;

  /// Başarımlar bölümü başlığı
  ///
  /// In tr, this message translates to:
  /// **'Başarımlar'**
  String get profileAchievementsTitle;

  /// Ayarlar bölümü başlığı
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get profileSettingsTitle;

  /// Zorluk tercihi ayarı
  ///
  /// In tr, this message translates to:
  /// **'Tercih edilen zorluk'**
  String get profileSettingDifficulty;

  /// Bildirimler ayarı
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get profileSettingNotifications;

  /// Günlük hatırlatıcı ayarı
  ///
  /// In tr, this message translates to:
  /// **'Günlük hatırlatıcı'**
  String get profileSettingReminder;

  /// Hatırlatıcı saati
  ///
  /// In tr, this message translates to:
  /// **'09:00'**
  String get profileReminderTime;

  /// Çıkış butonu
  ///
  /// In tr, this message translates to:
  /// **'Çıkış Yap'**
  String get profileSignOut;

  /// Dil ayarı etiketi
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get profileSettingLanguage;

  /// Sistem dili seçeneği
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get profileLanguageSystem;

  /// Türkçe dil seçeneği
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get profileLanguageTurkish;

  /// İngilizce dil seçeneği
  ///
  /// In tr, this message translates to:
  /// **'İngilizce'**
  String get profileLanguageEnglish;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
