import 'package:app/config/router/app_router.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';

final class AuthGuard {
  const AuthGuard._();

  static String? redirect({
    required AuthStatus status,
    required String location,
  }) {
    final bool isSplash = location == AppRouter.splashPath;
    final bool isAuth   = location == AppRouter.authPath;

    if (status == AuthStatus.unknown) {
      return isSplash ? null : AppRouter.splashPath;
    }

    if (status == AuthStatus.unauthenticated) {
      return isAuth ? null : AppRouter.authPath;
    }

    if (isSplash || isAuth) return AppRouter.homePath;

    return null;
  }
}
