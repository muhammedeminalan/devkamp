import 'package:app/features/auth/domain/entities/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithEmail();
  Future<void> signOut();
}
