import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/sections/app_section_header.dart';
import 'package:app/core/widgets/cards/app_category_card.dart';
import 'package:app/features/home/presentation/model/home_category_ui_model.dart';
import 'package:flutter/material.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  List<HomeCategoryUiModel> _buildCategories() {
    return const <HomeCategoryUiModel>[
      HomeCategoryUiModel(
        title: 'Flutter',
        solvedCount: 38,
        totalCount: 124,
        progress: 0.31,
        icon: Icons.flutter_dash_rounded,
        iconColor: Color(0xFF2563EB),
        iconBackgroundColor: Color(0xFFDBEAFE),
      ),
      HomeCategoryUiModel(
        title: 'Dart',
        solvedCount: 22,
        totalCount: 78,
        progress: 0.28,
        icon: Icons.code_rounded,
        iconColor: PrimaryColor.primary600,
        iconBackgroundColor: PrimaryColor.primary50,
      ),
      HomeCategoryUiModel(
        title: 'iOS',
        solvedCount: 17,
        totalCount: 62,
        progress: 0.27,
        icon: Icons.phone_iphone_rounded,
        iconColor: Color(0xFF0284C7),
        iconBackgroundColor: Color(0xFFE0F2FE),
      ),
      HomeCategoryUiModel(
        title: 'Android',
        solvedCount: 29,
        totalCount: 96,
        progress: 0.30,
        icon: Icons.android_rounded,
        iconColor: Color(0xFF16A34A),
        iconBackgroundColor: Color(0xFFDCFCE7),
      ),
      HomeCategoryUiModel(
        title: 'Firebase',
        solvedCount: 12,
        totalCount: 46,
        progress: 0.26,
        icon: Icons.cloud_rounded,
        iconColor: Color(0xFFEA580C),
        iconBackgroundColor: Color(0xFFFFEDD5),
      ),
      HomeCategoryUiModel(
        title: 'Clean Arch',
        solvedCount: 14,
        totalCount: 52,
        progress: 0.27,
        icon: Icons.account_tree_rounded,
        iconColor: Color(0xFF7C3AED),
        iconBackgroundColor: Color(0xFFEDE9FE),
      ),
      HomeCategoryUiModel(
        title: 'Git',
        solvedCount: 21,
        totalCount: 64,
        progress: 0.33,
        icon: Icons.merge_type_rounded,
        iconColor: Color(0xFF475569),
        iconBackgroundColor: Color(0xFFE2E8F0),
      ),
      HomeCategoryUiModel(
        title: 'Algoritma',
        solvedCount: 9,
        totalCount: 40,
        progress: 0.22,
        icon: Icons.psychology_alt_rounded,
        iconColor: Color(0xFFBE185D),
        iconBackgroundColor: Color(0xFFFCE7F3),
      ),
    ];
  }

  void _showAllCategoriesSheet(
    BuildContext context,
    List<HomeCategoryUiModel> categories,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _AllCategoriesSheet(categories: categories);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<HomeCategoryUiModel> categories = _buildCategories();
    final List<HomeCategoryUiModel> previewCategories = categories.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppSectionHeader(
          title: AppStrings.homeCategoriesTitle,
          actionLabel: AppStrings.homeSeeAll,
          onActionTap: () => _showAllCategoriesSheet(context, categories),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          itemCount: previewCategories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.12,
          ),
          itemBuilder: (BuildContext context, int index) {
            final HomeCategoryUiModel item = previewCategories[index];
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

class _AllCategoriesSheet extends StatelessWidget {
  const _AllCategoriesSheet({required this.categories});

  final List<HomeCategoryUiModel> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.82,
        maxChildSize: 0.92,
        minChildSize: 0.6,
        builder: (BuildContext context, ScrollController scrollController) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              children: <Widget>[
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: NeutralColor.neutral300,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  AppStrings.homeAllCategoriesTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: NeutralColor.neutral900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.homeAllCategoriesSubtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: NeutralColor.neutral500,
                      ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    itemCount: categories.length,
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
                        onTap: () => Navigator.of(context).pop(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
