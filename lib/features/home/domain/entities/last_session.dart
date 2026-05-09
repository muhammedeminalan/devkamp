// Kullanıcının en son başladığı quiz oturumunu temsil eder.
// Home ekranında "kaldığın yerden devam et" kartını doldurmak için kullanılır.
class LastSession {
  const LastSession({
    required this.categoryId,
    required this.categoryName,
    required this.topicName,
    required this.isRandom,
    required this.savedAt,
    this.topicId,
  });

  final String categoryId;
  final String categoryName;
  final String? topicId;
  final String topicName;
  final bool isRandom;
  final DateTime savedAt;
}
