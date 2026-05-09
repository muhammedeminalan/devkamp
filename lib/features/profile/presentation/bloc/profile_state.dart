import 'package:app/features/profile/domain/entities/achievement.dart';
import 'package:app/features/profile/domain/entities/category_performance.dart';
import 'package:app/features/profile/domain/entities/user_stats.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.stats,
    this.achievements = const <Achievement>[],
    this.categoryPerformance = const <CategoryPerformance>[],
    this.errorMessage,
  });

  final ProfileStatus status;
  final UserStats? stats;
  final List<Achievement> achievements;
  final List<CategoryPerformance> categoryPerformance;
  final String? errorMessage;

  ProfileState copyWith({
    ProfileStatus? status,
    UserStats? stats,
    List<Achievement>? achievements,
    List<CategoryPerformance>? categoryPerformance,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      achievements: achievements ?? this.achievements,
      categoryPerformance: categoryPerformance ?? this.categoryPerformance,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      <Object?>[status, stats, achievements, categoryPerformance, errorMessage];
}
