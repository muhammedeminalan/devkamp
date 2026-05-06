import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:app/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:injectable/injectable.dart';

// Gerçek AI ve soru API'si hazır olana kadar stabil veri sağlar.
@LazySingleton(as: QuizRepository)
class FakeQuizRepository implements QuizRepository {
  static const List<QuizQuestion> _allQuestions = <QuizQuestion>[
    QuizQuestion(
      id: 'q1',
      text: 'BLoC ve Riverpod arasındaki temel farklar nelerdir?',
      topic: 'State Management',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q2',
      text: 'StatefulWidget ile StatelessWidget\'ın farkını açıkla.',
      topic: 'Widget Temelleri',
      difficulty: QuestionDifficulty.easy,
    ),
    QuizQuestion(
      id: 'q3',
      text: 'Flutter\'da Future ve Stream arasındaki fark nedir?',
      topic: 'Async / Streams',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q4',
      text: 'BuildContext nedir ve neden önemlidir?',
      topic: 'Widget Temelleri',
      difficulty: QuestionDifficulty.easy,
    ),
    QuizQuestion(
      id: 'q5',
      text: 'GoRouter\'da ShellRoute ne işe yarar?',
      topic: 'Navigation & Routing',
      difficulty: QuestionDifficulty.hard,
    ),
    QuizQuestion(
      id: 'q6',
      text: 'Widget key\'leri ne zaman ve neden kullanmalısın?',
      topic: 'Widget Temelleri',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q7',
      text: 'get_it ve injectable birlikte nasıl çalışır?',
      topic: 'Dependency Injection',
      difficulty: QuestionDifficulty.hard,
    ),
    QuizQuestion(
      id: 'q8',
      text: 'Dart\'ta extension method ne zaman tercih edilmeli?',
      topic: 'Dart Özellikleri',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q9',
      text: 'Flutter\'da performans optimizasyonu için const constructor neden önemlidir?',
      topic: 'Performans',
      difficulty: QuestionDifficulty.medium,
    ),
    QuizQuestion(
      id: 'q10',
      text: 'Isolate nedir ve ne zaman kullanılmalıdır?',
      topic: 'Async / Streams',
      difficulty: QuestionDifficulty.hard,
    ),
  ];

  static const Map<String, String> _answers = <String, String>{
    'q1': '**Kısa cevap:** BLoC olay tabanlı ve kuralcı; Riverpod declarative ve derleme zamanı güvenlidir.\n\n**Temel farklar:**\n- BLoC, Event → State akışı üzerine kuruludur. Riverpod, UI\'ın watch ettiği provider\'lar sunar.\n- BLoC daha fazla boilerplate (event/state/bloc sınıfları) gerektirir.\n- Riverpod BuildContext bağımsızdır, derleme zamanında hata verir.\n\n**Hangisini seçmeli:**\n- BLoC: sıkı mimari kontrat isteyen büyük ekipler.\n- Riverpod: hız ve daha az kod isteyen küçük/orta ekipler.',
    'q2': '**StatelessWidget:** State tutmaz, sadece build() metodu ile render edilir. Dış parametreler değişmediği sürece yeniden çizilmez.\n\n**StatefulWidget:** Mutable state tutabilir. createState() ile bir State nesnesi oluşturur. setState() çağrıldığında widget yeniden çizilir.\n\n**Kural:** State yoksa StatelessWidget kullan — gereksiz karmaşıklıktan kaçın.',
    'q3': '**Future:** Tek bir async değer döner. Tamamlanır ya da hata verir. async/await ile kullanılır.\n\n**Stream:** Zaman içinde birden fazla değer yayar. Bir "veri kanalı" gibi düşün. listen() veya await for ile tüketilir.\n\n**Örnek:** HTTP isteği → Future. WebSocket mesajları → Stream.',
    'q4': '**BuildContext** widget\'ın widget tree içindeki konumunu temsil eder.\n\nŞunlar için gereklidir:\n- Theme ve MediaQuery erişimi\n- Navigator / go_router navigasyonu\n- BlocProvider.of gibi InheritedWidget okuma\n\n**Dikkat:** Context\'i async gap\'ten sonra kullanırken mounted kontrolü yap.',
    'q5': '**ShellRoute**, alt route\'ların üzerinde kalıcı bir UI kabuğu (ör. BottomNavigationBar) oluşturur.\n\nAlt route\'lar değişirken kabuk yeniden çizilmez, state korunur. StatefulShellRoute.indexedStack kullanarak her tab\'ın kendi navigation stack\'ini tutabilirsin.',
    'q6': '**Key\'ler** Flutter\'ın widget\'ları yeniden kullanırken kimliğini korumasını sağlar.\n\n- **ValueKey / ObjectKey:** liste öğelerini doğru eşleştirmek için.\n- **GlobalKey:** başka bir widget\'ın state\'ine veya RenderObject\'ine erişmek için.\n- **UniqueKey:** widget\'ı her zaman yeniden oluşturmak için.\n\n**Kural:** Aynı tipten birden fazla sibling widget varsa ve sıraları değişebiliyorsa key kullan.',
    'q7': '**get_it** service locator\'dır — singleton ve factory kayıtları tutar.\n\n**injectable** ise kod üretim aracıdır. @injectable, @lazySingleton gibi anotasyonları okur, build_runner ile get_it için registration kodunu otomatik üretir.\n\n**Akış:** Anotasyon ekle → build_runner çalıştır → injection_container.config.dart güncellenir → GetIt.instance<T>() ile eriş.',
    'q8': '**Extension method** mevcut tipe dışarıdan metod ekler, kaynak kodunu değiştirmeden.\n\n**Tercih et:**\n- Utility metodlar (context.textTheme, int.h spacing)\n- Kütüphane tiplerini genişletmek için\n- Mixin uygun değilse ve inheritance gerekmiyorsa\n\n**Kaçın:** Karmaşık iş mantığı için — anlaşılması zorlaşır.',
    'q9': '**const constructor** derleme zamanında nesneyi oluşturur ve Flutter tarafından önbelleğe alınır.\n\n**Avantajlar:**\n- Aynı const widget birden fazla yerde kullanılırsa tek instance oluşur.\n- rebuild sırasında Flutter bu widget\'ı atlayabilir (identical kontrolü geçer).\n\n**Kural:** Parametreler sabitlenebiliyorsa const kullan. Özellikle ağır alt ağaçlar için kritik.',
    'q10': '**Isolate** ayrı bir bellek alanında çalışan bağımsız bir Dart thread\'idir.\n\n**Ne zaman kullan:**\n- JSON parse gibi ağır CPU işlemleri ana thread\'i blokluyor\n- Görüntü işleme, şifreleme gibi uzun süren hesaplamalar\n\n**Flutter\'da:** compute() fonksiyonu basit isolate kullanımı için yeterlidir. Dart 2.15+ ile Isolate.run() kullanılabilir.',
  };

  @override
  Future<Result<List<QuizQuestion>>> getQuestions({
    required String categoryId,
    String? topicId,
    required bool isRandom,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final List<QuizQuestion> questions = List<QuizQuestion>.from(_allQuestions);
    if (isRandom) {
      questions.shuffle();
    }

    return Success(questions.take(10).toList());
  }

  @override
  Future<Result<String>> getAiAnswer({required String questionId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final String? answer = _answers[questionId];
    if (answer == null) {
      return const Failure(DataException('Bu soru için cevap bulunamadı.'));
    }

    return Success(answer);
  }
}
