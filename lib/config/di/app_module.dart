import 'package:app/config/router/app_router.dart';
import 'package:app/features/auth/domain/entities/app_user.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  // Firestore instance'ı lazy singleton olarak kayıt edilir;
  // her yerde aynı instance kullanılır.
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  // Gemini modeli tüm repository'ler tarafından paylaşılır;
  // dotenv main'de yüklendikten sonra güvenle erişilebilir.
  @lazySingleton
  GenerativeModel geminiModel() => GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
      );

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
