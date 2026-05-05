import 'package:app/features/auth/domain/entities/app_user.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  const SignInWithGoogleUseCase(this._repository);

  final AuthRepository _repository;

  Future<AppUser> call() {
    return _repository.signInWithGoogle();
  }
}
