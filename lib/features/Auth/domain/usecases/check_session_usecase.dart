import 'package:app/features/Auth/domain/entities/app_user.dart';
import 'package:app/features/Auth/domain/repositories/auth_repository.dart';

class CheckSessionUseCase {
  const CheckSessionUseCase(this._repository);

  final AuthRepository _repository;

  Future<AppUser?> call() {
    return _repository.getCurrentUser();
  }
}
