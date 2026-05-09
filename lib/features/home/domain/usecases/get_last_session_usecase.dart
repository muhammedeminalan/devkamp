import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/last_session.dart';
import 'package:app/features/home/domain/repositories/last_session_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLastSessionUseCase {
  const GetLastSessionUseCase(this._repository);

  final LastSessionRepository _repository;

  Future<Result<LastSession?>> call() => _repository.getLastSession();
}
