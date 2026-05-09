import 'package:app/features/home/domain/entities/category.dart';
import 'package:app/features/home/domain/entities/last_session.dart';
import 'package:app/features/home/domain/entities/learning_progress.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const <Category>[],
    this.progress,
    this.lastSession,
    this.errorMessage,
  });

  final HomeStatus status;
  final List<Category> categories;
  final LearningProgress? progress;
  // Kullanıcının son quiz oturumu; null ise "devam et" kartı gösterilmez.
  final LastSession? lastSession;
  final String? errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<Category>? categories,
    LearningProgress? progress,
    LastSession? lastSession,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      progress: progress ?? this.progress,
      lastSession: lastSession ?? this.lastSession,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      <Object?>[status, categories, progress, lastSession, errorMessage];
}
