import 'package:app/bootstrap/app_bootstrap.dart';
import 'package:app/config/di/injection_container.dart';
import 'package:app/features/topic/data/datasources/topic_seeder.dart';
import 'package:app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // Firestore'a Flutter/Dart/Python topic'lerini yaz (zaten varsa atlar).
  await TopicSeeder.seed(FirebaseFirestore.instance);
  await setupDependencies();
  runApp(const AppBootstrap());
}
