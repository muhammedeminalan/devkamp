import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:flutter/material.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kaydedilenler')),
      body: Center(
        child: Text(
          'Kaydedilen sorular bu ekrana gelecek.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: NeutralColor.neutral600,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
