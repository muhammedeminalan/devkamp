import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Uygulama dilini yönetir.
// Durum: Locale? — null olduğunda cihaz dili kullanılır.
class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(null) {
    _loadSaved();
  }

  static const String _key = 'selected_locale';

  // Kaydedilmiş dili SharedPreferences'tan yükler; yoksa null (cihaz dili).
  Future<void> _loadSaved() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? code = prefs.getString(_key);
    if (code != null) {
      emit(Locale(code));
    }
  }

  // Seçilen dili kaydeder ve uygulamaya uygular.
  Future<void> changeLocale(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
    emit(locale);
  }

  // Cihaz diline döner, kaydedilen tercihi siler.
  Future<void> resetToDevice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    emit(null);
  }
}
