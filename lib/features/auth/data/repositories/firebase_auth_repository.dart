import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/auth/domain/entities/app_user.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    required AuthRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AppUser?> getCurrentUser() async {
    final User? user = _remoteDataSource.currentUser;
    if (user == null) {
      dev.log('👤 getCurrentUser → oturum yok', name: 'FirebaseAuthRepository');
      return null;
    }
    dev.log('✅ getCurrentUser → userId: ${user.uid}', name: 'FirebaseAuthRepository');
    return _mapUser(user);
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    dev.log('🔑 Google sign-in başlatıldı', name: 'FirebaseAuthRepository');
    final User? user = await _remoteDataSource.signInWithGoogle();

    if (user == null) {
      dev.log('❌ Google sign-in: kullanıcı null döndü', name: 'FirebaseAuthRepository');
      throw const AuthException(
        'Google hesabı ile girişten kullanıcı bilgisi alınamadı.',
      );
    }

    dev.log('✅ Google sign-in başarılı | userId: ${user.uid}', name: 'FirebaseAuthRepository');
    return _mapUser(user);
  }

  @override
  Future<AppUser> signInWithEmail() async {
    dev.log('⚠️ E-posta girişi henüz aktif değil', name: 'FirebaseAuthRepository');
    throw const AuthException('E-posta ile giriş henüz aktif değil.');
  }

  @override
  Future<void> signOut() async {
    dev.log('🚪 Sign-out yapılıyor...', name: 'FirebaseAuthRepository');
    await _remoteDataSource.signOut();
    dev.log('✅ Sign-out başarılı', name: 'FirebaseAuthRepository');
  }

  AppUser _mapUser(User user) {
    return AppUser(
      id: user.uid,
      name: user.displayName ?? 'Kullanıcı',
      email: user.email ?? '',
      avatarUrl: user.photoURL,
    );
  }
}
