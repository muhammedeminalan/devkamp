import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/last_session.dart';

// Kullanıcının son quiz oturumunu okuma ve yazma işlemlerini soyutlar.
abstract interface class LastSessionRepository {
  Future<Result<LastSession?>> getLastSession();
  Future<Result<void>> saveLastSession(LastSession session);
}
