import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

// Bir öğrenim kategorisini sabit ve güvenli veri modeliyle taşımak için kullanılır.
@freezed
abstract class Category with _$Category {
  const factory Category({
    required String id,
    required String title,
    required int questionCount,
    required int colorValue,
    required String iconPath,
  }) = _Category;
}
