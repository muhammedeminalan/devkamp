import 'package:app/config/router/router_refresh_notifier.dart';
import 'package:app/app/navigation/presentation/widgets/main_shell_scaffold.dart';
import 'package:app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/Auth/presentation/view/auth_view.dart';
import 'package:app/features/Home/presentation/view/home_view.dart';
import 'package:app/features/Profile/presentation/view/profile_view.dart';
import 'package:app/features/Saved/presentation/view/saved_view.dart';
import 'package:app/features/Splash/presentation/view/splash_view.dart';
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
    initialLocation: splashPath,
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
    final AuthStatus status = _authBloc.state.status;
    final String location = state.matchedLocation;

    final bool isSplash = location == splashPath;
    final bool isAuth = location == authPath;

    if (status == AuthStatus.unknown) {
      if (isSplash) return null;
      return splashPath;
    }

    if (status == AuthStatus.unauthenticated) {
      if (isAuth) return null;
      return authPath;
    }

    if (isSplash || isAuth) {
      return homePath;
    }

    return null;
  }

  void dispose() {
    _refreshNotifier.dispose();
  }
}
