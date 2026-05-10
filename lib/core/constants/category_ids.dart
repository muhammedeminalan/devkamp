/// Firestore'daki kategori ID'lerinin merkezi sabitleri.
/// Bu ID'ler backend ile senkronize olmalı — değiştirmeden önce migration gerekir.
abstract final class CategoryIds {
  static const String flutter = 'flutter';
  static const String dart    = 'dart';
  static const String android = 'android';
  static const String python  = 'python';
  static const String ios     = 'ios';
}
