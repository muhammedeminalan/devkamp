import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';

// Profile ekranındaki toplam performans bilgisini tutarlı biçimde taşımak için kullanılır.
@freezed
abstract class UserStats with _$UserStats {
  const factory UserStats({
    required int totalSolved,
    required int correctAnswers,
    required int streakDays,
    required double accuracy,
    required String rank,
  }) = _UserStats;
}
