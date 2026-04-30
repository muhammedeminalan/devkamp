import 'package:app/config/theme/app_theme.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

import 'features/Splash/view/splash_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      home: const SplashView(),
    );
  }
}
