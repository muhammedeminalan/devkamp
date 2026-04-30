import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/bootstrap/app_bootstrap.dart';
import 'package:app/config/di/injection_container.dart';

void main() {
  setUpAll(() async {
    await setupDependencies();
  });

  testWidgets('App bootstrap renders MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(const AppBootstrap());
    await tester.pump(const Duration(seconds: 3));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
