import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:app/features/home/domain/repositories/home_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepository)
class FirestoreHomeRepository implements HomeRepository {
  FirestoreHomeRepository(this._firestore);

  final FirebaseFirestore _firestore;

  // Firestore topics dokümanını Category entity'sine dönüştürür.
  // Renk ve ikon, topic id'ye göre sabit eşleşmeyle belirlenir.
  Category _mapDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final Map<String, dynamic> data = doc.data()!;
    final String id = doc.id;
    final String name = data['name'] as String? ?? id;

    return Category(
      id: id,
      title: name,
      questionCount: data['questionCount'] as int? ?? 0,
      colorValue: _colorFor(id),
      iconPath: _iconFor(id),
    );
  }

  // Her topic için sabit renk değeri döndürür.
  int _colorFor(String topicId) {
    return switch (topicId) {
      'flutter' => Colors.blue.toARGB32(),
      'dart' => Colors.indigo.toARGB32(),
      'python' => Colors.green.toARGB32(),
      'android' => Colors.teal.toARGB32(),
      _ => Colors.purple.toARGB32(),
    };
  }

  // Her topic için SVG ikon yolu döndürür.
  String _iconFor(String topicId) {
    return switch (topicId) {
      'flutter' => 'assets/svg/dev_kamp_logo.svg',
      'dart' => 'assets/svg/dev_kamp_logo.svg',
      'python' => 'assets/svg/dev_kamp_logo.svg',
      _ => 'assets/svg/dev_kamp_logo.svg',
    };
  }

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      dev.log('📂 Topics Firestore\'dan çekiliyor...', name: 'FirestoreHomeRepository');

      final QuerySnapshot<Map<String, dynamic>> snap = await _firestore
          .collection('topics')
          .orderBy('order')
          .get();

      final List<Category> categories = snap.docs.map(_mapDoc).toList();

      dev.log(
        '✅ Topics hazır | count: ${categories.length}',
        name: 'FirestoreHomeRepository',
      );

      return Success(categories);
    } on Exception catch (e) {
      dev.log('❌ getCategories hatası: $e', name: 'FirestoreHomeRepository');
      return Failure(DataException('İçerikler yüklenemedi.'));
    }
  }

  @override
  Future<Result<LearningProgress>> getProgress() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      dev.log('⚠️ getProgress: kullanıcı giriş yapmamış', name: 'FirestoreHomeRepository');
      return const Success(
        LearningProgress(
          completedQuestions: 0,
          totalQuestions: 0,
          streakDays: 0,
          lastStudiedCategory: '',
        ),
      );
    }

    try {
      dev.log('📊 İlerleme verisi Firestore\'dan çekiliyor | userId: $uid', name: 'FirestoreHomeRepository');

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('userStats').doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        dev.log('📊 Henüz istatistik yok, sıfır döndürülüyor', name: 'FirestoreHomeRepository');
        return const Success(
          LearningProgress(
            completedQuestions: 0,
            totalQuestions: 0,
            streakDays: 0,
            lastStudiedCategory: '',
          ),
        );
      }

      final Map<String, dynamic> data = doc.data()!;
      final int totalSolved = data['totalSolved'] as int? ?? 0;
      final int correctAnswers = data['correctAnswers'] as int? ?? 0;
      final int streakDays = data['streakDays'] as int? ?? 0;

      dev.log(
        '✅ İlerleme hazır | totalSolved: $totalSolved | streak: $streakDays',
        name: 'FirestoreHomeRepository',
      );

      return Success(
        LearningProgress(
          // Toplam çözülen doğru cevap sayısı
          completedQuestions: correctAnswers,
          // Toplam çözülen soru (progress bar için)
          totalQuestions: totalSolved,
          streakDays: streakDays,
          lastStudiedCategory: '',
        ),
      );
    } on Exception catch (e) {
      dev.log('❌ getProgress hatası: $e', name: 'FirestoreHomeRepository');
      return Failure(DataException('İlerleme bilgisi yüklenemedi.'));
    }
  }
}
