import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/features/category/domain/entities/study_category.dart';
import 'package:flutter/material.dart';

// Bir topic'e ait AI üretimi kategorileri liste olarak gösterir.
class CategoryListSection extends StatelessWidget {
  const CategoryListSection({
    required this.categories,
    required this.onCategoryTap,
    super.key,
  });

  final List<StudyCategory> categories;
  final ValueChanged<StudyCategory> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        return _CategoryCard(
          category: categories[index],
          onTap: () => onCategoryTap(categories[index]),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.onTap,
  });

  final StudyCategory category;
  final VoidCallback onTap;

  String get _questionsLabel {
    if (category.questionsStatus == QuestionsStatus.generating) {
      return 'Sorular hazırlanıyor...';
    }
    if (category.questionCount == 0) {
      return 'İlk açılışta sorular oluşturulur';
    }
    return '${category.questionCount} soru';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: NeutralColor.neutral200),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(17, 24, 39, 0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: PrimaryColor.primary50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.topic_rounded,
                color: PrimaryColor.primary600,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: NeutralColor.neutral900,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _questionsLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: NeutralColor.neutral500,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: NeutralColor.neutral400,
            ),
          ],
        ),
      ),
    );
  }
}
