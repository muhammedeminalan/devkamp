import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:app/features/home/domain/repositories/home_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      return Failure(DataException('Ana kategoriler yüklenemedi: $e'));
    }
  }

  @override
  Future<Result<LearningProgress>> getProgress() async {
    // İlerleme takibi ilerleyen aşamada Firestore'a bağlanacak.
    // Şimdilik sabit veri döndürülür.
    dev.log('📊 İlerleme verisi alınıyor (sabit)', name: 'FirestoreHomeRepository');
    return const Success(
      LearningProgress(
        completedQuestions: 0,
        totalQuestions: 0,
        streakDays: 0,
        lastStudiedCategory: '',
      ),
    );
  }
}
