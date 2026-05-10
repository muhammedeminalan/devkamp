import 'package:app/config/router/app_router.dart';
import 'package:app/config/router/auth_guard.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthGuard.redirect', () {
    test('unknown iken splash disina giderse splashe yonlendirir', () {
      final String? result = AuthGuard.redirect(
        status: AuthStatus.unknown,
        location: '/home',
      );

      expect(result, AppRouter.splashPath);
    });

    test('unknown iken splashte kalir', () {
      final String? result = AuthGuard.redirect(
        status: AuthStatus.unknown,
        location: AppRouter.splashPath,
      );

      expect(result, isNull);
    });

    test('unauthenticated iken auth harici autha yonlendirir', () {
      final String? result = AuthGuard.redirect(
        status: AuthStatus.unauthenticated,
        location: '/saved',
      );

      expect(result, AppRouter.authPath);
    });

    test('authenticated iken splash veya authtan homea yonlendirir', () {
      final String? fromSplash = AuthGuard.redirect(
        status: AuthStatus.authenticated,
        location: AppRouter.splashPath,
      );
      final String? fromAuth = AuthGuard.redirect(
        status: AuthStatus.authenticated,
        location: AppRouter.authPath,
      );

      expect(fromSplash, AppRouter.homePath);
      expect(fromAuth, AppRouter.homePath);
    });

    test('authenticated iken protected routea geciste redirect etmez', () {
      final String? result = AuthGuard.redirect(
        status: AuthStatus.authenticated,
        location: '/profile',
      );

      expect(result, isNull);
    });
  });
}
