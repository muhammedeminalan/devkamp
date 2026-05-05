import 'package:app/config/router/app_router.dart';
import 'package:app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:app/features/auth/domain/entities/app_user.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  if (!sl.isRegistered<AuthRemoteDataSource>()) {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      FirebaseAuthRemoteDataSource.new,
    );
  }

  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => FirebaseAuthRepository(remoteDataSource: sl()),
    );
  }

  if (!sl.isRegistered<CheckSessionUseCase>()) {
    sl.registerLazySingleton<CheckSessionUseCase>(() => CheckSessionUseCase(sl()));
  }

  if (!sl.isRegistered<SignInWithGoogleUseCase>()) {
    sl.registerLazySingleton<SignInWithGoogleUseCase>(
      () => SignInWithGoogleUseCase(sl()),
    );
  }

  if (!sl.isRegistered<SignInWithEmailUseCase>()) {
    sl.registerLazySingleton<SignInWithEmailUseCase>(
      () => SignInWithEmailUseCase(sl()),
    );
  }

  if (!sl.isRegistered<SignOutUseCase>()) {
    sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl()));
  }

  final AppUser? initialUser = await sl<AuthRepository>().getCurrentUser();

  if (!sl.isRegistered<AuthBloc>()) {
    sl.registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        checkSessionUseCase: sl(),
        signInWithGoogleUseCase: sl(),
        signInWithEmailUseCase: sl(),
        signOutUseCase: sl(),
        initialUser: initialUser,
      ),
    );
  }

  if (!sl.isRegistered<AppRouter>()) {
    sl.registerLazySingleton<AppRouter>(() => AppRouter(authBloc: sl()));
  }
}
