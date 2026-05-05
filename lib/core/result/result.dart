import 'package:app/core/errors/app_exception.dart';

// Use case katmanında exception fırlatmadan akışı tip güvenli yürütmek için kullanılır.
sealed class Result<T> {
  const Result();
}

// Başarılı sonucu veri ile taşıyarak üst katmanda sade tüketim sağlar.
final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

// Hata durumunda AppException türlerini tek kanaldan taşımak için kullanılır.
final class Failure<T> extends Result<T> {
  const Failure(this.exception);

  final AppException exception;
}
