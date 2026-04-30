import 'package:app/features/Auth/domain/entities/app_user.dart';
import 'package:app/features/Auth/domain/usecases/check_session_usecase.dart';
import 'package:app/features/Auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:app/features/Auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:app/features/Auth/domain/usecases/sign_out_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CheckSessionUseCase checkSessionUseCase,
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required SignInWithEmailUseCase signInWithEmailUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _checkSessionUseCase = checkSessionUseCase,
        _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _signInWithEmailUseCase = signInWithEmailUseCase,
        _signOutUseCase = signOutUseCase,
        super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthSignInWithGoogleRequested>(_onAuthSignInWithGoogleRequested);
    on<AuthSignInWithEmailRequested>(_onAuthSignInWithEmailRequested);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
  }

  final CheckSessionUseCase _checkSessionUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final SignOutUseCase _signOutUseCase;

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final AppUser? user = await _checkSessionUseCase();
      if (user == null) {
        emit(
          state.copyWith(
            status: AuthStatus.unauthenticated,
            clearUser: true,
            isLoading: false,
            clearError: true,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearUser: true,
          isLoading: false,
          errorMessage: 'Oturum kontrolü sırasında hata oluştu: $error',
        ),
      );
    }
  }

  Future<void> _onAuthSignInWithGoogleRequested(
    AuthSignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final AppUser user = await _signInWithGoogleUseCase();
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearUser: true,
          isLoading: false,
          errorMessage: 'Google ile giriş başarısız: $error',
        ),
      );
    }
  }

  Future<void> _onAuthSignInWithEmailRequested(
    AuthSignInWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final AppUser user = await _signInWithEmailUseCase();
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearUser: true,
          isLoading: false,
          errorMessage: 'E-posta ile giriş başarısız: $error',
        ),
      );
    }
  }

  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await _signOutUseCase();
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearUser: true,
          isLoading: false,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Çıkış işlemi başarısız: $error',
        ),
      );
    }
  }
}
