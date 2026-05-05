import 'package:app/config/router/auth_guard.dart';
import 'package:app/config/router/router_refresh_notifier.dart';
import 'package:app/app/navigation/presentation/widgets/main_shell_scaffold.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/auth/presentation/view/auth_view.dart';
import 'package:app/features/home/presentation/view/home_view.dart';
import 'package:app/features/profile/presentation/view/profile_view.dart';
import 'package:app/features/saved/presentation/view/saved_view.dart';
import 'package:app/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter({required AuthBloc authBloc}) : _authBloc = authBloc {
    _refreshNotifier = RouterRefreshNotifier(_authBloc.stream);
  }

  static const String splashPath = '/splash';
  static const String authPath = '/auth';
  static const String homePath = '/home';
  static const String savedPath = '/saved';
  static const String profilePath = '/profile';

  final AuthBloc _authBloc;
  late final RouterRefreshNotifier _refreshNotifier;

  late final GoRouter router = GoRouter(
    initialLocation: _authBloc.state.status == AuthStatus.authenticated
        ? homePath
        : authPath,
    refreshListenable: _refreshNotifier,
    redirect: _redirect,
    routes: <RouteBase>[
      GoRoute(
        path: splashPath,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: authPath,
        builder: (BuildContext context, GoRouterState state) {
          return const AuthView();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return MainShellScaffold(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: homePath,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: savedPath,
                builder: (BuildContext context, GoRouterState state) {
                  return const SavedView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: profilePath,
                builder: (BuildContext context, GoRouterState state) {
                  return const ProfileView();
                },
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) {
      final AuthStatus status = _authBloc.state.status;
      if (status == AuthStatus.authenticated) {
        return const HomeView();
      }
      return const AuthView();
    },
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    return AuthGuard.redirect(
      status: _authBloc.state.status,
      location: state.matchedLocation,
    );
  }

  void dispose() {
    _refreshNotifier.dispose();
  }
}
