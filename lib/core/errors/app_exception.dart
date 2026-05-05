// Uygulamanın tüm katmanlarında standart hata modeli tutmak için kullanılır.
class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => 'AppException: $message';
}

// Kimlik doğrulama akışındaki hataları tek tipte yakalamak için ayrıştırılır.
class AuthException extends AppException {
  const AuthException(super.message);
}

// Veri kaynağı veya ağ erişimi kaynaklı hataları anlamlı ayırmak için kullanılır.
class DataException extends AppException {
  const DataException(super.message);
}

// Sınıflandırılamayan durumlarda güvenli varsayılan mesajla düşmek için kullanılır.
class UnexpectedException extends AppException {
  const UnexpectedException([super.message = 'Beklenmeyen bir hata oluştu']);
}
