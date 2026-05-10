import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Uygulama dilini yönetir.
// Durum: Locale? — null olduğunda cihaz dili kullanılır.
@lazySingleton
class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(null) {
    _loadSaved();
  }

  static const String _key = 'selected_locale';

  // Kaydedilmiş dili SharedPreferences'tan yükler.
  // Hata olursa sessizce yoksayar — null (cihaz dili) kalır.
  Future<void> _loadSaved() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? code = prefs.getString(_key);
      if (code != null) {
        emit(Locale(code));
      }
    } on Exception catch (e) {
      dev.log('⚠️ Locale yüklenemedi, cihaz dili kullanılıyor: $e', name: 'LocaleCubit');
    }
  }

  // Seçilen dili kaydeder ve uygulamaya uygular.
  Future<void> changeLocale(Locale locale) async {
    emit(locale); // UI hemen güncellenir
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, locale.languageCode);
    } on Exception catch (e) {
      dev.log('⚠️ Locale kaydedilemedi: $e', name: 'LocaleCubit');
    }
  }

  // Cihaz diline döner, kaydedilen tercihi siler.
  Future<void> resetToDevice() async {
    emit(null); // UI hemen güncellenir
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } on Exception catch (e) {
      dev.log('⚠️ Locale tercihi silinemedi: $e', name: 'LocaleCubit');
    }
  }
}
