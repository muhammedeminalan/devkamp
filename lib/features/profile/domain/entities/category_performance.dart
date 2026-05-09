// Bir kategorideki kullanıcı performansını tutar.
class CategoryPerformance {
  const CategoryPerformance({
    required this.categoryId,
    required this.categoryTitle,
    required this.totalSolved,
    required this.correctAnswers,
  });

  final String categoryId;
  final String categoryTitle;
  final int totalSolved;
  final int correctAnswers;

  // Doğru cevap oranı (0.0 - 1.0)
  double get accuracy =>
      totalSolved > 0 ? correctAnswers / totalSolved : 0.0;
}
