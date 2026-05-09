import 'package:app/features/category/domain/entities/study_category.dart';
import 'package:equatable/equatable.dart';

enum CategoryBlocStatus { initial, loading, generating, ready, error }

class CategoryState extends Equatable {
  const CategoryState({
    this.status = CategoryBlocStatus.initial,
    this.categories = const <StudyCategory>[],
    this.errorMessage,
  });

  final CategoryBlocStatus status;
  final List<StudyCategory> categories;
  final String? errorMessage;

  CategoryState copyWith({
    CategoryBlocStatus? status,
    List<StudyCategory>? categories,
    String? errorMessage,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, categories, errorMessage];
}
