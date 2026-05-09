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

  /// No description provided for @splashBrandPrefix.
  ///
  /// In tr, this message translates to:
  /// **'Dev'**
  String get splashBrandPrefix;

  /// No description provided for @splashBrandSuffix.
  ///
  /// In tr, this message translates to:
  /// **'Kamp'**
  String get splashBrandSuffix;

  /// No description provided for @splashSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bir profesyonel gibi mülakata gir.'**
  String get splashSubtitle;

  /// No description provided for @authBrandPrefix.
  ///
  /// In tr, this message translates to:
  /// **'Dev'**
  String get authBrandPrefix;

  /// No description provided for @authBrandSuffix.
  ///
  /// In tr, this message translates to:
  /// **'Kamp'**
  String get authBrandSuffix;

  /// No description provided for @authHeadlineLine1.
  ///
  /// In tr, this message translates to:
  /// **'Yazılım kariyerinde'**
  String get authHeadlineLine1;

  /// No description provided for @authHeadlineLine2.
  ///
  /// In tr, this message translates to:
  /// **'bir adım öne geç.'**
  String get authHeadlineLine2;

  /// No description provided for @authDescription.
  ///
  /// In tr, this message translates to:
  /// **'Gerçek mülakat sorularını çalış. Anında AI geri bildirimi al.'**
  String get authDescription;

  /// No description provided for @authGoogleContinue.
  ///
  /// In tr, this message translates to:
  /// **'Google ile Devam Et'**
  String get authGoogleContinue;

  /// No description provided for @authFreeNote.
  ///
  /// In tr, this message translates to:
  /// **'Sonsuza dek ücretsiz. Kredi kartı gerekmez.'**
  String get authFreeNote;

  /// No description provided for @homeFallbackUserName.
  ///
  /// In tr, this message translates to:
  /// **'Geliştirici'**
  String get homeFallbackUserName;

  /// No description provided for @homeContinueSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaldığın yerden devam et'**
  String get homeContinueSectionTitle;

  /// No description provided for @homeContinueButton.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get homeContinueButton;

  /// No description provided for @homeCategoriesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kategoriler'**
  String get homeCategoriesTitle;

  /// No description provided for @homeSeeAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü gör'**
  String get homeSeeAll;

  /// No description provided for @homeAllCategoriesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tüm Kategoriler'**
  String get homeAllCategoriesTitle;

  /// No description provided for @homeAllCategoriesSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Çalışmak istediğin alanı seç'**
  String get homeAllCategoriesSubtitle;

  /// No description provided for @homeMorningMotivation.
  ///
  /// In tr, this message translates to:
  /// **'Güne iyi bir başlangıç yap 🎯'**
  String get homeMorningMotivation;

  /// No description provided for @homeAfternoonMotivation.
  ///
  /// In tr, this message translates to:
  /// **'Bugün ilk soruyu çöz 💡'**
  String get homeAfternoonMotivation;

  /// No description provided for @homeEveningMotivation.
  ///
  /// In tr, this message translates to:
  /// **'Geceyi verimli geçir 🌙'**
  String get homeEveningMotivation;

  /// No description provided for @homeStreakFirst.
  ///
  /// In tr, this message translates to:
  /// **'İyi başladın, devam et! 💪'**
  String get homeStreakFirst;

  /// No description provided for @homeStreakKeep.
  ///
  /// In tr, this message translates to:
  /// **'{count} günlük serini koru 🔥'**
  String homeStreakKeep(int count);

  /// No description provided for @homeStreakMid.
  ///
  /// In tr, this message translates to:
  /// **'{count} gündür aralıksız çalışıyorsun 🚀'**
  String homeStreakMid(int count);

  /// No description provided for @homeStreakLegend.
  ///
  /// In tr, this message translates to:
  /// **'{count} günlük efsane seri! 👑'**
  String homeStreakLegend(int count);

  /// No description provided for @homeProgressStart.
  ///
  /// In tr, this message translates to:
  /// **'Çalışmaya Başla'**
  String get homeProgressStart;

  /// No description provided for @homeProgressFirstDay.
  ///
  /// In tr, this message translates to:
  /// **'İlk Gün! 🎯'**
  String get homeProgressFirstDay;

  /// No description provided for @homeProgressStreak.
  ///
  /// In tr, this message translates to:
  /// **'{count} Günlük Seri 🔥'**
  String homeProgressStreak(int count);

  /// No description provided for @homeQuestionsSuffix.
  ///
  /// In tr, this message translates to:
  /// **'soru'**
  String get homeQuestionsSuffix;

  /// No description provided for @savedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedilen Sorular'**
  String get savedTitle;

  /// No description provided for @savedReviewCountSuffix.
  ///
  /// In tr, this message translates to:
  /// **'tekrar edilecek soru'**
  String get savedReviewCountSuffix;

  /// No description provided for @savedFilterAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümü'**
  String get savedFilterAll;

  /// No description provided for @savedDifficultyEasy.
  ///
  /// In tr, this message translates to:
  /// **'Kolay'**
  String get savedDifficultyEasy;

  /// No description provided for @savedDifficultyMedium.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get savedDifficultyMedium;

  /// No description provided for @savedDifficultyHard.
  ///
  /// In tr, this message translates to:
  /// **'Zor'**
  String get savedDifficultyHard;

  /// No description provided for @savedEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kaydedilen soru yok'**
  String get savedEmptyTitle;

  /// No description provided for @savedEmptySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar etmek için soru kaydet — burada görünürler.'**
  String get savedEmptySubtitle;

  /// No description provided for @savedEmptyAction.
  ///
  /// In tr, this message translates to:
  /// **'Keşfetmeye başla'**
  String get savedEmptyAction;

  /// No description provided for @savedAiAnswer.
  ///
  /// In tr, this message translates to:
  /// **'AI Cevabı'**
  String get savedAiAnswer;

  /// No description provided for @categoryRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get categoryRetry;

  /// No description provided for @categoryNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Kategori bulunamadı.'**
  String get categoryNotFound;

  /// No description provided for @categoryRandomQuiz.
  ///
  /// In tr, this message translates to:
  /// **'Rastgele Quiz'**
  String get categoryRandomQuiz;

  /// No description provided for @categoryListLoading.
  ///
  /// In tr, this message translates to:
  /// **'Sorular hazırlanıyor...'**
  String get categoryListLoading;

  /// No description provided for @categoryListLoadingHint.
  ///
  /// In tr, this message translates to:
  /// **'İlk açılışta sorular oluşturulur'**
  String get categoryListLoadingHint;

  /// No description provided for @categoryGenerating.
  ///
  /// In tr, this message translates to:
  /// **'AI kategoriler hazırlanıyor...'**
  String get categoryGenerating;

  /// No description provided for @quizDifficultyEasy.
  ///
  /// In tr, this message translates to:
  /// **'Kolay'**
  String get quizDifficultyEasy;

  /// No description provided for @quizDifficultyMedium.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get quizDifficultyMedium;

  /// No description provided for @quizDifficultyHard.
  ///
  /// In tr, this message translates to:
  /// **'Zor'**
  String get quizDifficultyHard;

  /// No description provided for @quizSeeAnswer.
  ///
  /// In tr, this message translates to:
  /// **'Cevabı Gör'**
  String get quizSeeAnswer;

  /// No description provided for @quizAiAnswer.
  ///
  /// In tr, this message translates to:
  /// **'AI Cevabı'**
  String get quizAiAnswer;

  /// No description provided for @quizAnswerError.
  ///
  /// In tr, this message translates to:
  /// **'AI cevabı yüklenemedi.'**
  String get quizAnswerError;

  /// No description provided for @quizAnswerErrorHint.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantını kontrol et ve tekrar dene.'**
  String get quizAnswerErrorHint;

  /// No description provided for @quizAnswerRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get quizAnswerRetry;

  /// No description provided for @quizEvalKnew.
  ///
  /// In tr, this message translates to:
  /// **'Biliyordum'**
  String get quizEvalKnew;

  /// No description provided for @quizEvalMissed.
  ///
  /// In tr, this message translates to:
  /// **'Bilmiyordum'**
  String get quizEvalMissed;

  /// No description provided for @quizNextQuestion.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki Soru'**
  String get quizNextQuestion;

  /// No description provided for @quizResultRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Çöz'**
  String get quizResultRetry;

  /// No description provided for @quizResultBack.
  ///
  /// In tr, this message translates to:
  /// **'Geri Dön'**
  String get quizResultBack;

  /// No description provided for @quizResultKnew.
  ///
  /// In tr, this message translates to:
  /// **'Bildim'**
  String get quizResultKnew;

  /// No description provided for @quizResultMissed.
  ///
  /// In tr, this message translates to:
  /// **'Bilmedim'**
  String get quizResultMissed;

  /// No description provided for @quizProgressLabel.
  ///
  /// In tr, this message translates to:
  /// **'Soru {current} / {total}'**
  String quizProgressLabel(int current, int total);

  /// No description provided for @quizTopicCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} soru'**
  String quizTopicCount(int count);

  /// No description provided for @profileStatsTotal.
  ///
  /// In tr, this message translates to:
  /// **'Toplam'**
  String get profileStatsTotal;

  /// No description provided for @profileStatsStreak.
  ///
  /// In tr, this message translates to:
  /// **'Seri'**
  String get profileStatsStreak;

  /// No description provided for @profileStatsBest.
  ///
  /// In tr, this message translates to:
  /// **'En İyi'**
  String get profileStatsBest;

  /// No description provided for @profileStatsQuestionSuffix.
  ///
  /// In tr, this message translates to:
  /// **'soru'**
  String get profileStatsQuestionSuffix;

  /// No description provided for @profileStatsDaySuffix.
  ///
  /// In tr, this message translates to:
  /// **'gün'**
  String get profileStatsDaySuffix;

  /// No description provided for @profilePerformanceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kategori Performansı'**
  String get profilePerformanceTitle;

  /// No description provided for @profileAchievementsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Başarımlar'**
  String get profileAchievementsTitle;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get profileSettingsTitle;

  /// No description provided for @profileSettingDifficulty.
  ///
  /// In tr, this message translates to:
  /// **'Tercih edilen zorluk'**
  String get profileSettingDifficulty;

  /// No description provided for @profileSettingNotifications.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get profileSettingNotifications;

  /// No description provided for @profileSettingReminder.
  ///
  /// In tr, this message translates to:
  /// **'Günlük hatırlatıcı'**
  String get profileSettingReminder;

  /// No description provided for @profileReminderTime.
  ///
  /// In tr, this message translates to:
  /// **'09:00'**
  String get profileReminderTime;

  /// No description provided for @profileSignOut.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış Yap'**
  String get profileSignOut;
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
