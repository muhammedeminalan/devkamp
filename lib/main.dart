import 'package:app/bootstrap/app_bootstrap.dart';
import 'package:app/config/di/injection_container.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const AppBootstrap());
}
