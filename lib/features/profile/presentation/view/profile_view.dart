import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/profile/domain/usecases/get_achievements_usecase.dart';
import 'package:app/features/profile/domain/usecases/get_category_performance_usecase.dart';
import 'package:app/features/profile/domain/usecases/get_user_stats_usecase.dart';
import 'package:app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/features/profile/presentation/bloc/profile_event.dart';
import 'package:app/features/profile/presentation/bloc/profile_state.dart';
import 'package:app/features/profile/presentation/sections/profile_achievements_section.dart';
import 'package:app/features/profile/presentation/sections/profile_header_section.dart';
import 'package:app/features/profile/presentation/sections/profile_performance_section.dart';
import 'package:app/features/profile/presentation/sections/profile_settings_section.dart';
import 'package:app/features/profile/presentation/sections/profile_stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (BuildContext context) => ProfileBloc(
        getUserStatsUseCase: GetIt.instance<GetUserStatsUseCase>(),
        getAchievementsUseCase: GetIt.instance<GetAchievementsUseCase>(),
        getCategoryPerformanceUseCase: GetIt.instance<GetCategoryPerformanceUseCase>(),
      )..add(const ProfileDataLoaded()),
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final AuthState authState = context.watch<AuthBloc>().state;
    final String name = authState.user?.name ?? 'Kullanıcı';
    final String email = authState.user?.email ?? '-';
    final String? avatarUrl = authState.user?.avatarUrl;

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
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (BuildContext context, ProfileState profileState) {
              if (profileState.status == ProfileStatus.loading ||
                  profileState.status == ProfileStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (profileState.status == ProfileStatus.failure ||
                  profileState.stats == null) {
                return Center(
                  child: Text(
                    profileState.errorMessage ?? 'Profil verileri yüklenemedi.',
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  children: <Widget>[
                    ProfileHeaderSection(
                      name: name,
                      email: email,
                      avatarUrl: avatarUrl,
                      rank: profileState.stats!.rank,
                    ),
                    24.h,
                    ProfileStatsSection(stats: profileState.stats!),
                    24.h,
                    ProfilePerformanceSection(
                      performances: profileState.categoryPerformance,
                    ),
                    24.h,
                    ProfileAchievementsSection(
                      achievements: profileState.achievements,
                    ),
                    24.h,
                    ProfileSettingsSection(
                      isSigningOut: authState.isLoading,
                      onSignOut: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthSignOutRequested());
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
