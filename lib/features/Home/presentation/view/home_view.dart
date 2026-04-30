import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthState authState = context.watch<AuthBloc>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Hoş geldin ${authState.user?.name ?? ''}'.trim(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: NeutralColor.neutral900,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Şimdilik fake auth ile çalışıyoruz. Gerçek servis geldiğinde sadece data katmanını değiştireceğiz.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: NeutralColor.neutral600,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
