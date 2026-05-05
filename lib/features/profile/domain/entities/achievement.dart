import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';

// Rozet verisini tek modelde tutarak görünüm ve kaynak katmanını ayırır.
@freezed
abstract class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required String iconPath,
    required bool isUnlocked,
  }) = _Achievement;
}
