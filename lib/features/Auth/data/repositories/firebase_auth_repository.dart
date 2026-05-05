import 'package:app/core/errors/app_exception.dart';
import 'package:app/features/Auth/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/Auth/domain/entities/app_user.dart';
import 'package:app/features/Auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    required AuthRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AppUser?> getCurrentUser() async {
    final User? user = _remoteDataSource.currentUser;
    if (user == null) {
      return null;
    }
    return _mapUser(user);
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    final User? user = await _remoteDataSource.signInWithGoogle();

    if (user == null) {
      throw const AuthException(
        'Google hesabı ile girişten kullanıcı bilgisi alınamadı.',
      );
    }

    return _mapUser(user);
  }

  @override
  Future<AppUser> signInWithEmail() async {
    throw const AuthException('E-posta ile giriş henüz aktif değil.');
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
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
