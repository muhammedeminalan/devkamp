import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/cards/app_category_card.dart';
import 'package:app/features/Home/presentation/model/home_category_ui_model.dart';
import 'package:flutter/material.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HomeCategoryUiModel> categories = <HomeCategoryUiModel>[
      const HomeCategoryUiModel(
        title: 'Flutter',
        solvedCount: 38,
        totalCount: 124,
        progress: 0.31,
        icon: Icons.flutter_dash_rounded,
        iconColor: Color(0xFF2563EB),
        iconBackgroundColor: Color(0xFFDBEAFE),
      ),
      const HomeCategoryUiModel(
        title: 'Dart',
        solvedCount: 22,
        totalCount: 78,
        progress: 0.28,
        icon: Icons.code_rounded,
        iconColor: PrimaryColor.primary600,
        iconBackgroundColor: PrimaryColor.primary50,
      ),
      const HomeCategoryUiModel(
        title: 'iOS',
        solvedCount: 17,
        totalCount: 62,
        progress: 0.27,
        icon: Icons.phone_iphone_rounded,
        iconColor: Color(0xFF0284C7),
        iconBackgroundColor: Color(0xFFE0F2FE),
      ),
      const HomeCategoryUiModel(
        title: 'Android',
        solvedCount: 29,
        totalCount: 96,
        progress: 0.30,
        icon: Icons.android_rounded,
        iconColor: Color(0xFF16A34A),
        iconBackgroundColor: Color(0xFFDCFCE7),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              AppStrings.homeCategoriesTitle,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: NeutralColor.neutral900,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.homeSeeAll,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: PrimaryColor.primary600,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          itemCount: categories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.12,
          ),
          itemBuilder: (BuildContext context, int index) {
            final HomeCategoryUiModel item = categories[index];
            return AppCategoryCard(
              title: item.title,
              solvedCount: item.solvedCount,
              totalCount: item.totalCount,
              progress: item.progress,
              icon: Icon(item.icon),
              iconColor: item.iconColor,
              iconBackgroundColor: item.iconBackgroundColor,
            );
          },
        ),
      ],
    );
  }
}
