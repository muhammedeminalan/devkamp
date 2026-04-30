import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/Splash/presentation/widgets/splash_background.dart';
import 'package:app/features/Splash/presentation/widgets/splash_dot_loader.dart';
import 'package:app/features/Splash/presentation/widgets/splash_logo_card.dart';
import 'package:app/features/Splash/presentation/widgets/splash_title.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBackground(
        child: Padding(
          padding: 40.all,
          child: const Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SplashLogoCard(),
                    SizedBox(height: 22),
                    SplashTitle(),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 64,
                child: SplashDotLoader(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
