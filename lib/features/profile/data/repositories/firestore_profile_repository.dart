import 'dart:developer' as dev;

import 'package:app/core/constants/assets/app_svg_paths.dart';
import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:app/features/profile/domain/entities/category_performance.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';
import 'package:app/features/profile/domain/repositories/profile_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class FirestoreProfileRepository implements ProfileRepository {
  FirestoreProfileRepository(this._firestore);

  final FirebaseFirestore _firestore;

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<Result<UserStats>> getUserStats() async {
    final String? uid = _userId;
    if (uid == null) {
      dev.log('⚠️ getUserStats: kullanıcı giriş yapmamış', name: 'FirestoreProfileRepository');
      return const Success(UserStats(
        totalSolved: 0,
        correctAnswers: 0,
        streakDays: 0,
        accuracy: 0,
        rank: 'Başlangıç',
      ));
    }

    try {
      dev.log('📊 Kullanıcı istatistikleri çekiliyor | userId: $uid', name: 'FirestoreProfileRepository');

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('userStats').doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        dev.log('📊 Henüz istatistik yok | userId: $uid', name: 'FirestoreProfileRepository');
        return const Success(UserStats(
          totalSolved: 0,
          correctAnswers: 0,
          streakDays: 0,
          accuracy: 0,
          rank: 'Başlangıç',
        ));
      }

      final Map<String, dynamic> data = doc.data()!;
      final int totalSolved = data['totalSolved'] as int? ?? 0;
      final int correctAnswers = data['correctAnswers'] as int? ?? 0;
      final int streakDays = data['streakDays'] as int? ?? 0;
      final double accuracy =
          totalSolved > 0 ? correctAnswers / totalSolved : 0;

      // Toplam çözülen soru sayısına göre rank belirlenir.
      final String rank = _rankFor(totalSolved);

      dev.log(
        '✅ İstatistikler hazır | totalSolved: $totalSolved | rank: $rank',
        name: 'FirestoreProfileRepository',
      );

      return Success(UserStats(
        totalSolved: totalSolved,
        correctAnswers: correctAnswers,
        streakDays: streakDays,
        accuracy: accuracy,
        rank: rank,
      ));
    } on Exception catch (e) {
      dev.log('❌ getUserStats hatası: $e', name: 'FirestoreProfileRepository');
      return Failure(DataException('İstatistikler yüklenemedi: $e'));
    }
  }

  @override
  Future<Result<List<CategoryPerformance>>> getCategoryPerformance() async {
    final String? uid = _userId;
    if (uid == null) {
      return const Success(<CategoryPerformance>[]);
    }

    try {
      dev.log('📊 Kategori performansı çekiliyor | userId: $uid', name: 'FirestoreProfileRepository');

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('userStats').doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        return const Success(<CategoryPerformance>[]);
      }

      final Map<String, dynamic>? categoriesMap =
          doc.data()!['categories'] as Map<String, dynamic>?;

      if (categoriesMap == null || categoriesMap.isEmpty) {
        return const Success(<CategoryPerformance>[]);
      }

      final List<CategoryPerformance> result = categoriesMap.entries.map((entry) {
        final Map<String, dynamic> cat =
            Map<String, dynamic>.from(entry.value as Map);
        return CategoryPerformance(
          categoryId: entry.key,
          categoryTitle: cat['title'] as String? ?? entry.key,
          totalSolved: cat['totalSolved'] as int? ?? 0,
          correctAnswers: cat['correctAnswers'] as int? ?? 0,
        );
      }).toList()
        // En çok çözülenden en aza sırala
        ..sort((a, b) => b.totalSolved.compareTo(a.totalSolved));

      dev.log('✅ Kategori performansı hazır | count: ${result.length}', name: 'FirestoreProfileRepository');
      return Success(result);
    } on Exception catch (e) {
      dev.log('❌ getCategoryPerformance hatası: $e', name: 'FirestoreProfileRepository');
      return Failure(DataException('Kategori performansı yüklenemedi: $e'));
    }
  }

  @override
  Future<Result<void>> updateStreak() async {
    final String? uid = _userId;
    if (uid == null) {
      dev.log('⚠️ updateStreak: kullanıcı giriş yapmamış', name: 'FirestoreProfileRepository');
      return const Success(null);
    }

    try {
      dev.log('🔥 Streak kontrol ediliyor | userId: $uid', name: 'FirestoreProfileRepository');

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('userStats').doc(uid).get();

      final Map<String, dynamic>? data = doc.exists ? doc.data() : null;

      final Timestamp? lastActiveTimestamp = data?['lastActiveDate'] as Timestamp?;
      final DateTime? lastActive = lastActiveTimestamp?.toDate();
      final int currentStreak = data?['streakDays'] as int? ?? 0;

      final DateTime now = DateTime.now();
      // Saati sıfırla, sadece gün karşılaştır.
      final DateTime today = DateTime(now.year, now.month, now.day);

      int newStreak;

      if (lastActive == null) {
        // İlk giriş — serisi 1'den başlar.
        newStreak = 1;
      } else {
        final DateTime lastDay =
            DateTime(lastActive.year, lastActive.month, lastActive.day);
        final int diff = today.difference(lastDay).inDays;

        if (diff == 0) {
          // Bugün zaten aktif → streak değişmez.
          // Ama sıfırsa (hiç set edilmemişse) 1'e başlat.
          if (currentStreak > 0) {
            dev.log('🔥 Bugün zaten aktif, streak değişmedi | streak: $currentStreak', name: 'FirestoreProfileRepository');
            return const Success(null);
          }
          newStreak = 1;
        } else if (diff == 1) {
          // Dün aktifti → seri devam ediyor.
          newStreak = currentStreak + 1;
        } else {
          // 2+ gün ara → seri sıfırlandı.
          newStreak = 1;
        }
      }

      await _firestore.collection('userStats').doc(uid).set(
        <String, dynamic>{
          'streakDays': newStreak,
          'lastActiveDate': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      dev.log('✅ Streak güncellendi | newStreak: $newStreak', name: 'FirestoreProfileRepository');
      return const Success(null);
    } on Exception catch (e) {
      dev.log('❌ updateStreak hatası: $e', name: 'FirestoreProfileRepository');
      return Failure(DataException('Streak güncellenemedi: $e'));
    }
  }

  // Çözülen soru sayısına göre kullanıcı rütbesi döndürür.
  String _rankFor(int totalSolved) {
    if (totalSolved >= 100) return 'Uzman';
    if (totalSolved >= 50) return 'İleri Seviye';
    if (totalSolved >= 20) return 'Orta Seviye';
    if (totalSolved >= 5) return 'Başlangıç+';
    return 'Başlangıç';
  }

  @override
  Future<Result<List<Achievement>>> getAchievements() async {
    final String? uid = _userId;
    if (uid == null) {
      return Success(_defaultAchievements(totalSolved: 0, streakDays: 0));
    }

    try {
      dev.log('🏆 Başarımlar hesaplanıyor | userId: $uid', name: 'FirestoreProfileRepository');

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('userStats').doc(uid).get();

      final Map<String, dynamic>? data = doc.exists ? doc.data() : null;
      final int totalSolved = data?['totalSolved'] as int? ?? 0;
      final int streakDays = data?['streakDays'] as int? ?? 0;

      dev.log('✅ Başarımlar hazır', name: 'FirestoreProfileRepository');
      return Success(_defaultAchievements(
        totalSolved: totalSolved,
        streakDays: streakDays,
      ));
    } on Exception catch (e) {
      dev.log('❌ getAchievements hatası: $e', name: 'FirestoreProfileRepository');
      return Failure(DataException('Başarımlar yüklenemedi: $e'));
    }
  }

  // Kullanıcı istatistiklerine göre başarımların kilit durumunu belirler.
  List<Achievement> _defaultAchievements({
    required int totalSolved,
    required int streakDays,
  }) {
    return <Achievement>[
      Achievement(
        id: 'first_solve',
        title: 'İlk Çözüm',
        description: 'İlk soruyu yanıtladın',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: totalSolved >= 1,
      ),
      Achievement(
        id: 'solve_5',
        title: '5 Soru',
        description: '5 soru yanıtladın',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: totalSolved >= 5,
      ),
      Achievement(
        id: 'solve_20',
        title: '20 Soru',
        description: '20 soru yanıtladın',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: totalSolved >= 20,
      ),
      Achievement(
        id: 'solve_50',
        title: '50 Soru',
        description: '50 soru yanıtladın',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: totalSolved >= 50,
      ),
      Achievement(
        id: 'streak_5',
        title: '5 Günlük Seri',
        description: '5 gün üst üste çalış',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: streakDays >= 5,
      ),
      Achievement(
        id: 'streak_30',
        title: '30 Günlük Seri',
        description: '30 gün üst üste çalış',
        iconPath: AppSvgPaths.devKampLogo,
        isUnlocked: streakDays >= 30,
      ),
    ];
  }
}
