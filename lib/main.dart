import 'package:app/bootstrap/app_bootstrap.dart';
import 'package:app/config/di/injection_container.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // API key'leri .env dosyasından yükle; uygulama başlamadan önce hazır olmalı.
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupDependencies();
  runApp(const AppBootstrap());
}
