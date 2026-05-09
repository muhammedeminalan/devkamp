import 'dart:developer' as dev;

import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/data/repositories/fake_quiz_repository.dart';
import 'package:app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

// Soru listesi için FakeQuizRepository'yi devralır; AI cevabı için Gemini API kullanır.
@LazySingleton(as: QuizRepository)
class GeminiQuizRepository extends FakeQuizRepository {
  // late: dotenv yüklendikten sonra ilk kullanımda oluşturulur.
  late final GenerativeModel _model = GenerativeModel(
    model: 'gemini-flash-latest',
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
  );

  @override
  Future<Result<String>> getAiAnswer({
    required String questionText,
    required String topic,
    required String categoryId,
  }) async {
    dev.log(
      '▶ getAiAnswer başladı | topic: $topic | category: $categoryId',
      name: 'GeminiQuizRepository',
    );

    try {
      // Eğitim odaklı, kısa ve markdown formatında cevap üretmesi için prompt.
      final String prompt = '''
Sen deneyimli bir Flutter/Dart eğitmenisin.
Kategori: $categoryId
Konu: $topic

Aşağıdaki mülakat sorusunu yanıtla. Cevabın:
- Kısa ve net olsun (maksimum 300 kelime)
- Kod örneği içeriyorsa Dart/Flutter kodu kullansın
- Markdown formatında olsun (bold, kod blokları, listeler)
- Türkçe olsun

Soru: $questionText
''';

      dev.log('📤 Gemini isteği gönderiliyor...', name: 'GeminiQuizRepository');

      final GenerateContentResponse response = await _model.generateContent(
        <Content>[Content.text(prompt)],
      );

      final String? text = response.text;

      dev.log(
        '📥 Gemini yanıtı alındı | boş mu: ${text == null || text.isEmpty}',
        name: 'GeminiQuizRepository',
      );

      if (text == null || text.isEmpty) {
        dev.log('⚠️ Gemini boş yanıt döndü', name: 'GeminiQuizRepository');
        return const Failure(DataException('AI cevap üretemedi.'));
      }

      dev.log(
        '✅ Başarılı | cevap uzunluğu: ${text.length} karakter',
        name: 'GeminiQuizRepository',
      );
      return Success(text);
    } on Exception catch (e, st) {
      dev.log(
        '❌ Hata: $e',
        name: 'GeminiQuizRepository',
        error: e,
        stackTrace: st,
      );
      return Failure(DataException('AI servisine bağlanılamadı: $e'));
    }
  }
}
