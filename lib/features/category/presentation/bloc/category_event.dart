sealed class CategoryEvent {
  const CategoryEvent();
}

// Ekran açıldığında kategorileri yükler; yoksa üretim başlatır.
class CategoriesLoadRequested extends CategoryEvent {
  const CategoriesLoadRequested({
    required this.topicId,
    required this.topicName,
    required this.userId,
  });

  final String topicId;
  final String topicName;
  final String userId;
}
