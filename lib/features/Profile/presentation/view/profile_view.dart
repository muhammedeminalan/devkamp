import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/Profile/presentation/sections/profile_achievements_section.dart';
import 'package:app/features/Profile/presentation/sections/profile_header_section.dart';
import 'package:app/features/Profile/presentation/sections/profile_performance_section.dart';
import 'package:app/features/Profile/presentation/sections/profile_settings_section.dart';
import 'package:app/features/Profile/presentation/sections/profile_stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthState state = context.watch<AuthBloc>().state;
    final String name = state.user?.name ?? 'Kullanıcı';
    final String email = state.user?.email ?? '-';

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (AuthState previous, AuthState current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (BuildContext context, AuthState state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              children: <Widget>[
                ProfileHeaderSection(name: name, email: email),
                24.h,
                const ProfileStatsSection(),
                24.h,
                const ProfilePerformanceSection(),
                24.h,
                const ProfileAchievementsSection(),
                24.h,
                ProfileSettingsSection(
                  isSigningOut: state.isLoading,
                  onSignOut: () {
                    context.read<AuthBloc>().add(const AuthSignOutRequested());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
