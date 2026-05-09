import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// context.l10n.xxx şeklinde kısa erişim sağlar.
// Örnek: context.l10n.quizSeeAnswer
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
