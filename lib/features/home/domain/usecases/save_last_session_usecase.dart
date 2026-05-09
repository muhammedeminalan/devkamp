import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/last_session.dart';
import 'package:app/features/home/domain/repositories/last_session_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveLastSessionUseCase {
  const SaveLastSessionUseCase(this._repository);

  final LastSessionRepository _repository;

  Future<Result<void>> call(LastSession session) =>
      _repository.saveLastSession(session);
}
