import 'package:app/config/router/app_router.dart';
import 'package:app/features/auth/domain/entities/app_user.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @preResolve
  Future<AuthBloc> authBloc(
    CheckSessionUseCase checkSessionUseCase,
    SignInWithGoogleUseCase signInWithGoogleUseCase,
    SignInWithEmailUseCase signInWithEmailUseCase,
    SignOutUseCase signOutUseCase,
    AuthRepository authRepository,
  ) async {
    final AppUser? initialUser = await authRepository.getCurrentUser();
    return AuthBloc(
      checkSessionUseCase: checkSessionUseCase,
      signInWithGoogleUseCase: signInWithGoogleUseCase,
      signInWithEmailUseCase: signInWithEmailUseCase,
      signOutUseCase: signOutUseCase,
      initialUser: initialUser,
    );
  }

  @lazySingleton
  AppRouter appRouter(AuthBloc authBloc) => AppRouter(authBloc: authBloc);
}
