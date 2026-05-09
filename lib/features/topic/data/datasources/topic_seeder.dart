import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';

// Uygulama ilk açılışında Firestore'a Flutter/Dart/Python topic'lerini yazar.
// Zaten varsa atlar; böylece her başlatmada gereksiz yazma yapılmaz.
class TopicSeeder {
  static Future<void> seed(FirebaseFirestore firestore) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> check =
          await firestore.collection('topics').doc('flutter').get();

      if (check.exists) {
        dev.log('Topics zaten mevcut, seeder atlanıyor.', name: 'TopicSeeder');
        return;
      }

      const List<Map<String, dynamic>> topics = <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 'flutter',
          'name': 'Flutter',
          'order': 1,
        },
        <String, dynamic>{
          'id': 'dart',
          'name': 'Dart',
          'order': 2,
        },
        <String, dynamic>{
          'id': 'python',
          'name': 'Python',
          'order': 3,
        },
      ];

      final WriteBatch batch = firestore.batch();
      for (final Map<String, dynamic> topic in topics) {
        final DocumentReference<Map<String, dynamic>> ref =
            firestore.collection('topics').doc(topic['id'] as String);
        batch.set(ref, <String, dynamic>{
          'name': topic['name'],
          'order': topic['order'],
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
      dev.log("✅ Topics Firestore'a yazıldı.", name: 'TopicSeeder');
    } on Exception catch (e) {
      dev.log('❌ Seeder hatası: $e', name: 'TopicSeeder');
    }
  }
}
