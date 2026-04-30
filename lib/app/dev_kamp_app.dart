import 'package:app/config/theme/app_theme.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DevKampApp extends StatelessWidget {
  const DevKampApp({
    required this.router,
    super.key,
  });

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
