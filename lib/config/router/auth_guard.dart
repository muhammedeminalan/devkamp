import 'package:app/features/Auth/presentation/bloc/auth_bloc.dart';

final class AuthGuard {
  const AuthGuard._();

  static const String splashPath = '/splash';
  static const String authPath = '/auth';
  static const String homePath = '/home';

  static String? redirect({
    required AuthStatus status,
    required String location,
  }) {
    final bool isSplash = location == splashPath;
    final bool isAuth = location == authPath;

    if (status == AuthStatus.unknown) {
      if (isSplash) {
        return null;
      }
      return splashPath;
    }

    if (status == AuthStatus.unauthenticated) {
      if (isAuth) {
        return null;
      }
      return authPath;
    }

    if (isSplash || isAuth) {
      return homePath;
    }

    return null;
  }
}
