import 'dart:developer' as dev;

import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:app/features/quiz/domain/usecases/generate_questions_usecase.dart';
import 'package:app/features/quiz/domain/usecases/get_ai_answer_usecase.dart';
import 'package:app/features/quiz/domain/usecases/get_quiz_questions_usecase.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:app/features/saved/domain/usecases/remove_saved_question_usecase.dart';
import 'package:app/features/saved/domain/usecases/save_question_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required GetQuizQuestionsUseCase getQuizQuestionsUseCase,
    required GetAiAnswerUseCase getAiAnswerUseCase,
    required GenerateQuestionsUseCase generateQuestionsUseCase,
    required SaveQuestionUseCase saveQuestionUseCase,
    required RemoveSavedQuestionUseCase removeSavedQuestionUseCase,
  })  : _getQuestions = getQuizQuestionsUseCase,
        _getAiAnswer = getAiAnswerUseCase,
        _generateQuestions = generateQuestionsUseCase,
        _saveQuestion = saveQuestionUseCase,
        _removeQuestion = removeSavedQuestionUseCase,
        super(const QuizState()) {
    on<QuizStarted>(_onQuizStarted);
    on<QuizAnswerRequested>(_onAnswerRequested);
    on<QuizAnswerStreamComplete>(_onAnswerStreamComplete);
    on<QuizEvaluated>(_onEvaluated);
    on<QuizNextQuestion>(_onNextQuestion);
    on<QuizRestarted>(_onRestarted);
    on<QuizQuestionBookmarked>(_onBookmarked);
    on<QuizAnswerRetried>(_onAnswerRetried);
  }

  final GetQuizQuestionsUseCase _getQuestions;
  final GetAiAnswerUseCase _getAiAnswer;
  final GenerateQuestionsUseCase _generateQuestions;
  final SaveQuestionUseCase _saveQuestion;
  final RemoveSavedQuestionUseCase _removeQuestion;

  Future<void> _onQuizStarted(
    QuizStarted event,
    Emitter<QuizState> emit,
  ) async {
    dev.log(
      '🎯 Quiz başlatıldı | categoryId: ${event.categoryId} | topicId: ${event.topicId}',
      name: 'QuizBloc',
    );
    emit(state.copyWith(
      status: QuizStatus.loading,
      categoryId: event.categoryId,
      topicId: event.topicId ?? '',
      categoryName: event.categoryName,
    ));

    final Result<List<QuizQuestion>> result = await _getQuestions(
      categoryId: event.categoryId,
      topicId: event.topicId,
      isRandom: event.isRandom,
    );

    switch (result) {
      case Failure<List<QuizQuestion>>():
        dev.log(
          '❌ Sorular yüklenemedi: ${result.exception.message}',
          name: 'QuizBloc',
        );
        emit(state.copyWith(
          status: QuizStatus.failure,
          errorMessage: result.exception.message,
        ));
        return;

      case Success<List<QuizQuestion>>() when result.data.isEmpty:
        // Firestore'da soru yok; AI ile üret.
        dev.log(
          '🤖 Soru yok, AI ile üretim başlatılıyor | categoryId: ${event.categoryId}',
          name: 'QuizBloc',
        );
        emit(state.copyWith(status: QuizStatus.generating));

        final Result<void> genResult = await _generateQuestions(
          categoryId: event.categoryId,
          topicId: event.topicId ?? '',
          topicName: event.topicName,
          categoryName: event.categoryName,
        );

        if (genResult is Failure) {
          dev.log(
            '❌ Soru üretimi başarısız: ${genResult.exception.message}',
            name: 'QuizBloc',
          );
          emit(state.copyWith(
            status: QuizStatus.failure,
            errorMessage: genResult.exception.message,
          ));
          return;
        }

        dev.log('✅ Soru üretimi tamamlandı, tekrar çekiliyor...', name: 'QuizBloc');

        // Üretim tamamlandı; soruları tekrar çek.
        final Result<List<QuizQuestion>> generated = await _getQuestions(
          categoryId: event.categoryId,
          topicId: event.topicId,
          isRandom: event.isRandom,
        );

        switch (generated) {
          case Success<List<QuizQuestion>>():
            dev.log(
              '✅ Sorular hazır | count: ${generated.data.length}',
              name: 'QuizBloc',
            );
            emit(state.copyWith(
              status: QuizStatus.question,
              questions: generated.data,
              currentIndex: 0,
              answerStage: AnswerStage.hidden,
              evalResult: EvalResult.none,
              isBookmarked: false,
              knewIndices: <int>{},
              missedIndices: <int>{},
            ));
          case Failure<List<QuizQuestion>>():
            dev.log(
              '❌ Üretim sonrası çekim başarısız: ${generated.exception.message}',
              name: 'QuizBloc',
            );
            emit(state.copyWith(
              status: QuizStatus.failure,
              errorMessage: generated.exception.message,
            ));
        }

      case Success<List<QuizQuestion>>():
        dev.log(
          '✅ Sorular mevcut | count: ${result.data.length}',
          name: 'QuizBloc',
        );
        emit(state.copyWith(
          status: QuizStatus.question,
          questions: result.data,
          currentIndex: 0,
          answerStage: AnswerStage.hidden,
          evalResult: EvalResult.none,
          isBookmarked: false,
          knewIndices: <int>{},
          missedIndices: <int>{},
        ));
    }
  }

  Future<void> _onAnswerRequested(
    QuizAnswerRequested event,
    Emitter<QuizState> emit,
  ) async {
    final QuizQuestion? q = state.currentQuestion;
    if (q == null) {
      dev.log('⚠️ Mevcut soru null, cevap isteği iptal edildi', name: 'QuizBloc');
      return;
    }

    dev.log(
      '💬 Cevap isteniyor | questionId: ${q.id} | topic: ${q.topic}',
      name: 'QuizBloc',
    );
    emit(state.copyWith(answerStage: AnswerStage.loading));

    // questionId ile Firestore cache kontrolü yapılır; yoksa Gemini üretir.
    final Result<String> result = await _getAiAnswer(
      questionId: q.id,
      questionText: q.text,
      topic: q.topic,
      categoryId: state.categoryId,
    );

    switch (result) {
      case Success<String>():
        dev.log('✅ Cevap alındı | questionId: ${q.id}', name: 'QuizBloc');
        emit(state.copyWith(
          answerStage: AnswerStage.streaming,
          answerText: result.data,
        ));
      case Failure<String>():
        dev.log(
          '❌ Cevap alınamadı: ${result.exception.message}',
          name: 'QuizBloc',
        );
        emit(state.copyWith(
          answerStage: AnswerStage.error,
          errorMessage: result.exception.message,
        ));
    }
  }

  void _onAnswerStreamComplete(
    QuizAnswerStreamComplete event,
    Emitter<QuizState> emit,
  ) {
    emit(state.copyWith(answerStage: AnswerStage.answered));
  }

  Future<void> _onEvaluated(
    QuizEvaluated event,
    Emitter<QuizState> emit,
  ) async {
    final Set<int> knewIndices = Set<int>.from(state.knewIndices);
    final Set<int> missedIndices = Set<int>.from(state.missedIndices);

    // Daha önce değerlendirilmişse çift sayımı önle.
    final bool alreadyAnswered = knewIndices.contains(state.currentIndex) ||
        missedIndices.contains(state.currentIndex);

    knewIndices.remove(state.currentIndex);
    missedIndices.remove(state.currentIndex);

    if (event.knew) {
      knewIndices.add(state.currentIndex);
    } else {
      missedIndices.add(state.currentIndex);
    }

    emit(state.copyWith(
      evalResult: event.knew ? EvalResult.knew : EvalResult.missed,
      knewIndices: knewIndices,
      missedIndices: missedIndices,
    ));

    // Daha önce değerlendirilmemişse Firestore'da kullanıcı istatistiklerini artır.
    if (!alreadyAnswered) {
      _incrementUserStats(knew: event.knew);
    }
  }

  // Firestore'daki userStats dokümanını FieldValue.increment ile günceller.
  // fire-and-forget: UI'ı bloklamaz, hata olursa log'a düşer.
  void _incrementUserStats({required bool knew}) {
    final String? uid = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    FirebaseFirestore.instance.collection('userStats').doc(uid).set(
      <String, dynamic>{
        'totalSolved': FieldValue.increment(1),
        'correctAnswers': FieldValue.increment(knew ? 1 : 0),
        'lastActiveDate': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    ).then((_) {
      dev.log('📊 userStats güncellendi | knew: $knew', name: 'QuizBloc');
    }).catchError((Object e) {
      dev.log('❌ userStats güncelleme hatası: $e', name: 'QuizBloc');
    });
  }

  void _onNextQuestion(
    QuizNextQuestion event,
    Emitter<QuizState> emit,
  ) {
    if (state.isLastQuestion) {
      emit(state.copyWith(status: QuizStatus.complete));
      return;
    }

    emit(state.copyWith(
      currentIndex: state.currentIndex + 1,
      answerStage: AnswerStage.hidden,
      evalResult: EvalResult.none,
      isBookmarked: false,
      answerText: null,
      errorMessage: null,
    ));
  }

  Future<void> _onRestarted(
    QuizRestarted event,
    Emitter<QuizState> emit,
  ) async {
    if (state.questions.isEmpty) return;

    final List<QuizQuestion> reshuffled =
        List<QuizQuestion>.from(state.questions)..shuffle();

    emit(state.copyWith(
      status: QuizStatus.question,
      questions: reshuffled,
      currentIndex: 0,
      answerStage: AnswerStage.hidden,
      evalResult: EvalResult.none,
      isBookmarked: false,
      knewIndices: <int>{},
      missedIndices: <int>{},
      answerText: null,
      errorMessage: null,
    ));
  }

  Future<void> _onBookmarked(
    QuizQuestionBookmarked event,
    Emitter<QuizState> emit,
  ) async {
    final QuizQuestion? q = state.currentQuestion;
    if (q == null) return;

    final bool willBookmark = !state.isBookmarked;
    // UI'ı hemen güncelle; Firestore işlemi arka planda yapılır.
    emit(state.copyWith(isBookmarked: willBookmark));

    if (willBookmark) {
      dev.log('🔖 Soru kaydediliyor | questionId: ${q.id}', name: 'QuizBloc');
      final Result<void> result = await _saveQuestion(
        questionId: q.id,
        questionText: q.text,
        categoryId: state.categoryId,
        categoryTitle: state.categoryName,
      );
      if (result is Failure) {
        dev.log('❌ Soru kaydedilemedi: ${result.exception.message}', name: 'QuizBloc');
        // Hata durumunda bookmark'ı geri al.
        emit(state.copyWith(isBookmarked: false));
      } else {
        dev.log('✅ Soru kaydedildi | questionId: ${q.id}', name: 'QuizBloc');
      }
    } else {
      // Kayıtlı soruyu silmek için docId formatı: {userId}_{questionId}.
      // FirebaseAuth.instance üzerinden uid alınır.
      final String? uid = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;
      final String docId = '${uid}_${q.id}';
      dev.log('🗑️ Bookmark kaldırılıyor | docId: $docId', name: 'QuizBloc');
      final Result<void> result = await _removeQuestion(docId);
      if (result is Failure) {
        dev.log('❌ Bookmark kaldırılamadı: ${result.exception.message}', name: 'QuizBloc');
        emit(state.copyWith(isBookmarked: true));
      } else {
        dev.log('✅ Bookmark kaldırıldı | docId: $docId', name: 'QuizBloc');
      }
    }
  }

  Future<void> _onAnswerRetried(
    QuizAnswerRetried event,
    Emitter<QuizState> emit,
  ) async {
    add(const QuizAnswerRequested());
  }
}
