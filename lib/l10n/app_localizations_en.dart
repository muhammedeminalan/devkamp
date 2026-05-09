// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'DevKamp';

  @override
  String get splashBrandPrefix => 'Dev';

  @override
  String get splashBrandSuffix => 'Kamp';

  @override
  String get splashSubtitle => 'Enter interviews like a professional.';

  @override
  String get authBrandPrefix => 'Dev';

  @override
  String get authBrandSuffix => 'Kamp';

  @override
  String get authHeadlineLine1 => 'Level up your';

  @override
  String get authHeadlineLine2 => 'software career.';

  @override
  String get authDescription =>
      'Practice real interview questions. Get instant AI feedback.';

  @override
  String get authGoogleContinue => 'Continue with Google';

  @override
  String get authFreeNote => 'Free forever. No credit card required.';

  @override
  String get homeFallbackUserName => 'Developer';

  @override
  String get homeContinueSectionTitle => 'Continue where you left off';

  @override
  String get homeContinueButton => 'Continue';

  @override
  String get homeCategoriesTitle => 'Categories';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeAllCategoriesTitle => 'All Categories';

  @override
  String get homeAllCategoriesSubtitle => 'Choose the area you want to study';

  @override
  String get homeMorningMotivation => 'Start the day strong 🎯';

  @override
  String get homeAfternoonMotivation => 'Solve your first question today 💡';

  @override
  String get homeEveningMotivation => 'Make tonight productive 🌙';

  @override
  String get homeStreakFirst => 'Great start, keep going! 💪';

  @override
  String homeStreakKeep(int count) {
    return 'Keep your $count-day streak 🔥';
  }

  @override
  String homeStreakMid(int count) {
    return '$count days of non-stop studying 🚀';
  }

  @override
  String homeStreakLegend(int count) {
    return '$count-day legendary streak! 👑';
  }

  @override
  String get homeProgressStart => 'Start Studying';

  @override
  String get homeProgressFirstDay => 'Day One! 🎯';

  @override
  String homeProgressStreak(int count) {
    return '$count-Day Streak 🔥';
  }

  @override
  String get homeQuestionsSuffix => 'questions';

  @override
  String get savedTitle => 'Saved Questions';

  @override
  String get savedReviewCountSuffix => 'questions to review';

  @override
  String get savedFilterAll => 'All';

  @override
  String get savedDifficultyEasy => 'Easy';

  @override
  String get savedDifficultyMedium => 'Medium';

  @override
  String get savedDifficultyHard => 'Hard';

  @override
  String get savedEmptyTitle => 'No saved questions yet';

  @override
  String get savedEmptySubtitle =>
      'Save questions to review — they\'ll appear here.';

  @override
  String get savedEmptyAction => 'Start exploring';

  @override
  String get savedAiAnswer => 'AI Answer';

  @override
  String get categoryRetry => 'Retry';

  @override
  String get categoryNotFound => 'Category not found.';

  @override
  String get categoryRandomQuiz => 'Random Quiz';

  @override
  String get categoryListLoading => 'Preparing questions...';

  @override
  String get categoryListLoadingHint =>
      'Questions are generated on first launch';

  @override
  String get categoryGenerating => 'AI is preparing categories...';

  @override
  String get quizDifficultyEasy => 'Easy';

  @override
  String get quizDifficultyMedium => 'Medium';

  @override
  String get quizDifficultyHard => 'Hard';

  @override
  String get quizSeeAnswer => 'See Answer';

  @override
  String get quizAiAnswer => 'AI Answer';

  @override
  String get quizAnswerError => 'Failed to load AI answer.';

  @override
  String get quizAnswerErrorHint => 'Check your connection and try again.';

  @override
  String get quizAnswerRetry => 'Retry';

  @override
  String get quizEvalKnew => 'I knew it';

  @override
  String get quizEvalMissed => 'I didn\'t know';

  @override
  String get quizNextQuestion => 'Next Question';

  @override
  String get quizResultRetry => 'Try Again';

  @override
  String get quizResultBack => 'Go Back';

  @override
  String get quizResultKnew => 'Knew';

  @override
  String get quizResultMissed => 'Missed';

  @override
  String quizProgressLabel(int current, int total) {
    return 'Question $current / $total';
  }

  @override
  String quizTopicCount(int count) {
    return '$count questions';
  }

  @override
  String get profileStatsTotal => 'Total';

  @override
  String get profileStatsStreak => 'Streak';

  @override
  String get profileStatsBest => 'Best';

  @override
  String get profileStatsQuestionSuffix => 'questions';

  @override
  String get profileStatsDaySuffix => 'days';

  @override
  String get profilePerformanceTitle => 'Category Performance';

  @override
  String get profileAchievementsTitle => 'Achievements';

  @override
  String get profileSettingsTitle => 'Settings';

  @override
  String get profileSettingDifficulty => 'Preferred difficulty';

  @override
  String get profileSettingNotifications => 'Notifications';

  @override
  String get profileSettingReminder => 'Daily reminder';

  @override
  String get profileReminderTime => '09:00';

  @override
  String get profileSignOut => 'Sign Out';
}
