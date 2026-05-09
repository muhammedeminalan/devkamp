import 'package:app/config/theme/app_theme.dart';
import 'package:app/core/locale/locale_cubit.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DevKampApp extends StatelessWidget {
  const DevKampApp({
    required this.router,
    super.key,
  });

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    // LocaleCubit'ten gelen locale'i dinle.
    // null → MaterialApp cihaz dilini otomatik seçer.
    final Locale? locale = context.watch<LocaleCubit>().state;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // null geçilince Flutter cihaz dilini kullanır;
      // Türkçe veya İngilizce seçilince o dil sabit kalır.
      locale: locale,
      onGenerateTitle: (BuildContext ctx) => AppLocalizations.of(ctx).appName,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
