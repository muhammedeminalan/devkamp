import 'package:app/config/router/app_router.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/home/domain/entities/last_session.dart';
import 'package:app/features/home/presentation/bloc/home_bloc.dart';
import 'package:app/features/home/presentation/bloc/home_event.dart';
import 'package:app/features/home/presentation/bloc/home_state.dart';
import 'package:app/features/home/presentation/sections/home_categories_section.dart';
import 'package:app/features/home/presentation/sections/home_continue_section.dart';
import 'package:app/features/home/presentation/sections/home_header_section.dart';
import 'package:app/features/home/presentation/sections/home_progress_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      // DI, HomeBloc bağımlılıklarını otomatik çözer.
      create: (BuildContext context) =>
          GetIt.instance<HomeBloc>()..add(const HomeDataLoaded()),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final AuthState authState = context.watch<AuthBloc>().state;
    final String userName =
        authState.user?.name ?? context.l10n.homeFallbackUserName;
    final String? avatarUrl = authState.user?.avatarUrl;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            if (state.status == HomeStatus.loading ||
                state.status == HomeStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == HomeStatus.failure || state.progress == null) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'Home verileri yüklenemedi.',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HomeHeaderSection(
                      userName: userName,
                      streakDays: state.progress?.streakDays ?? 0,
                      avatarUrl: avatarUrl,
                    ),
                    16.h,
                    HomeProgressSection(progress: state.progress!),
                    // Son oturum varsa "Devam Et" kartını göster
                    if (state.lastSession != null) ...<Widget>[
                      24.h,
                      HomeContinueSection(
                        categoryName: state.lastSession!.categoryName,
                        topicName: state.lastSession!.topicName,
                        onTap: () => _navigateToLastSession(context, state.lastSession!),
                      ),
                    ],
                    24.h,
                    HomeCategoriesSection(categories: state.categories),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Son oturumun parametrelerine göre quiz sayfasına yönlendirir.
  void _navigateToLastSession(BuildContext context, LastSession session) {
    context.push(
      AppRouter.quizPath,
      extra: <String, dynamic>{
        'categoryId': session.categoryId,
        'topicId': session.topicId,
        'topicName': session.topicName,
        'categoryName': session.categoryName,
        'isRandom': session.isRandom,
      },
    );
  }
}
