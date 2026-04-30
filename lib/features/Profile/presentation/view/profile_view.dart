import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/widgets/small_button_loader.dart';
import 'package:app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthState authState = context.watch<AuthBloc>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              authState.user?.name ?? 'Kullanıcı',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: NeutralColor.neutral900,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              authState.user?.email ?? '-',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: NeutralColor.neutral600,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            FilledButton(
              onPressed: authState.isLoading
                  ? null
                  : () {
                      context.read<AuthBloc>().add(const AuthSignOutRequested());
                    },
              child: authState.isLoading
                  ? const SmallButtonLoader()
                  : const Text('Çıkış Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
