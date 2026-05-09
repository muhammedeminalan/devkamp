import 'dart:developer' as dev;

import 'package:app/core/result/result.dart';
import 'package:app/features/category/domain/entities/study_category.dart';
import 'package:app/features/category/domain/usecases/generate_categories_usecase.dart';
import 'package:app/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:app/features/category/presentation/bloc/category_event.dart';
import 'package:app/features/category/presentation/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GenerateCategoriesUseCase generateCategoriesUseCase,
  })  : _getCategories = getCategoriesUseCase,
        _generateCategories = generateCategoriesUseCase,
        super(const CategoryState()) {
    on<CategoriesLoadRequested>(_onCategoriesLoadRequested);
  }

  final GetCategoriesUseCase _getCategories;
  final GenerateCategoriesUseCase _generateCategories;

  Future<void> _onCategoriesLoadRequested(
    CategoriesLoadRequested event,
    Emitter<CategoryState> emit,
  ) async {
    dev.log(
      '📂 Kategoriler yükleniyor | topicId: ${event.topicId}',
      name: 'CategoryBloc',
    );
    emit(state.copyWith(status: CategoryBlocStatus.loading));

    // Firestore'dan mevcut kategorileri getir.
    final Result<List<StudyCategory>> result =
        await _getCategories(topicId: event.topicId);

    switch (result) {
      case Failure<List<StudyCategory>>():
        dev.log(
          '❌ Kategoriler yüklenemedi: ${result.exception.message}',
          name: 'CategoryBloc',
        );
        emit(state.copyWith(
          status: CategoryBlocStatus.error,
          errorMessage: result.exception.message,
        ));
        return;

      case Success<List<StudyCategory>>() when result.data.isNotEmpty:
        // Kategoriler Firestore'da mevcut, direkt göster.
        dev.log(
          '✅ Kategoriler mevcut | count: ${result.data.length}',
          name: 'CategoryBloc',
        );
        emit(state.copyWith(
          status: CategoryBlocStatus.ready,
          categories: result.data,
        ));
        return;

      case Success<List<StudyCategory>>():
        // Hiç kategori yok; AI ile üretim başlat.
        dev.log(
          '🤖 Kategori yok, AI ile üretim başlatılıyor | topicId: ${event.topicId}',
          name: 'CategoryBloc',
        );
        emit(state.copyWith(status: CategoryBlocStatus.generating));
    }

    final Result<void> genResult = await _generateCategories(
      topicId: event.topicId,
      topicName: event.topicName,
      userId: event.userId,
    );

    if (genResult is Failure) {
      dev.log(
        '❌ Kategori üretimi başarısız: ${genResult.exception.message}',
        name: 'CategoryBloc',
      );
      emit(state.copyWith(
        status: CategoryBlocStatus.error,
        errorMessage: genResult.exception.message,
      ));
      return;
    }

    dev.log('✅ Kategori üretimi tamamlandı, tekrar çekiliyor...', name: 'CategoryBloc');

    // Üretim tamamlandı; kategorileri tekrar çek.
    final Result<List<StudyCategory>> finalResult =
        await _getCategories(topicId: event.topicId);

    switch (finalResult) {
      case Success<List<StudyCategory>>():
        dev.log(
          '✅ Kategoriler hazır | count: ${finalResult.data.length}',
          name: 'CategoryBloc',
        );
        emit(state.copyWith(
          status: CategoryBlocStatus.ready,
          categories: finalResult.data,
        ));
      case Failure<List<StudyCategory>>():
        dev.log(
          '❌ Son çekim başarısız: ${finalResult.exception.message}',
          name: 'CategoryBloc',
        );
        emit(state.copyWith(
          status: CategoryBlocStatus.error,
          errorMessage: finalResult.exception.message,
        ));
    }
  }
}
