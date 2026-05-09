import 'dart:async';
import 'dart:developer' as dev;

import 'package:app/features/auth/domain/entities/app_user.dart';
import 'package:app/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:app/features/topic/data/datasources/topic_seeder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    AppUser? initialUser,
  })  : _checkSessionUseCase = checkSessionUseCase,
        _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _signInWithEmailUseCase = signInWithEmailUseCase,
        _signOutUseCase = signOutUseCase,
        super(
          initialUser == null
              ? const AuthState(status: AuthStatus.unauthenticated)
              : AuthState(
                  status: AuthStatus.authenticated,
                  user: initialUser,
                ),
        ) {
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
    dev.log('🔍 Oturum kontrol ediliyor...', name: 'AuthBloc');
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final AppUser? user = await _checkSessionUseCase();
      if (user == null) {
        dev.log('👤 Aktif oturum yok → unauthenticated', name: 'AuthBloc');
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

      dev.log('✅ Oturum aktif | userId: ${user.id}', name: 'AuthBloc');
      // Kullanıcı doğrulandı; topic seeder'ı auth sonrası çalıştır.
      unawaited(TopicSeeder.seed(FirebaseFirestore.instance));
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
          clearError: true,
        ),
      );
    } on Exception catch (error) {
      dev.log('❌ Oturum kontrol hatası: $error', name: 'AuthBloc');
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
    dev.log('🔑 Google ile giriş başlatıldı', name: 'AuthBloc');
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final AppUser user = await _signInWithGoogleUseCase();
      dev.log('✅ Google girişi başarılı | userId: ${user.id}', name: 'AuthBloc');
      // Kullanıcı giriş yaptı; topic seeder'ı auth sonrası çalıştır.
      unawaited(TopicSeeder.seed(FirebaseFirestore.instance));
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
          clearError: true,
        ),
      );
    } on Exception catch (error) {
      dev.log('❌ Google giriş hatası: $error', name: 'AuthBloc');
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
    dev.log('🔑 E-posta ile giriş başlatıldı', name: 'AuthBloc');
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final AppUser user = await _signInWithEmailUseCase();
      dev.log('✅ E-posta girişi başarılı | userId: ${user.id}', name: 'AuthBloc');
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
          clearError: true,
        ),
      );
    } on Exception catch (error) {
      dev.log('❌ E-posta giriş hatası: $error', name: 'AuthBloc');
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
    dev.log('🚪 Çıkış yapılıyor...', name: 'AuthBloc');
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await _signOutUseCase();
      dev.log('✅ Çıkış başarılı', name: 'AuthBloc');
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearUser: true,
          isLoading: false,
          clearError: true,
        ),
      );
    } on Exception catch (error) {
      dev.log('❌ Çıkış hatası: $error', name: 'AuthBloc');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Çıkış işlemi başarısız: $error',
        ),
      );
    }
  }
}
