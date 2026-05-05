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

      expect(result, AuthGuard.splashPath);
    });

    test('unknown iken splashte kalir', () {
      final String? result = AuthGuard.redirect(
        status: AuthStatus.unknown,
        location: AuthGuard.splashPath,
      );

      expect(result, isNull);
    });

    test('unauthenticated iken auth harici autha yonlendirir', () {
      final String? result = AuthGuard.redirect(
        status: AuthStatus.unauthenticated,
        location: '/saved',
      );

      expect(result, AuthGuard.authPath);
    });

    test('authenticated iken splash veya authtan homea yonlendirir', () {
      final String? fromSplash = AuthGuard.redirect(
        status: AuthStatus.authenticated,
        location: AuthGuard.splashPath,
      );
      final String? fromAuth = AuthGuard.redirect(
        status: AuthStatus.authenticated,
        location: AuthGuard.authPath,
      );

      expect(fromSplash, AuthGuard.homePath);
      expect(fromAuth, AuthGuard.homePath);
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
