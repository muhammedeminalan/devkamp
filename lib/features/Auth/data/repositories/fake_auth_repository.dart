import 'package:app/features/Auth/domain/entities/app_user.dart';
import 'package:app/features/Auth/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  bool _isAuthenticated = false;
  AppUser? _cachedUser;

  @override
  Future<AppUser?> getCurrentUser() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!_isAuthenticated) return null;
    return _cachedUser;
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    const AppUser user = AppUser(
      id: 'fake-google-1',
      name: 'Muhammed Emin',
      email: 'emin.dev@example.com',
    );
    _isAuthenticated = true;
    _cachedUser = user;
    return user;
  }

  @override
  Future<AppUser> signInWithEmail() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    const AppUser user = AppUser(
      id: 'fake-email-1',
      name: 'Muhammed Emin',
      email: 'emin.email@example.com',
    );
    _isAuthenticated = true;
    _cachedUser = user;
    return user;
  }

  @override
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    _isAuthenticated = false;
    _cachedUser = null;
  }
}
