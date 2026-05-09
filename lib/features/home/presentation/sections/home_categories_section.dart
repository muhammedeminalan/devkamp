import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/core/widgets/cards/app_category_card.dart';
import 'package:app/core/widgets/sections/app_section_header.dart';
import 'package:app/features/home/domain/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({
    required this.categories,
    super.key,
  });

  final List<Category> categories;

  List<Category> get _previewCategories => categories.take(4).toList();

  Color _resolveBackgroundColor(Color color) {
    return Color.alphaBlend(
      color.withValues(alpha: 0.18),
      Colors.white,
    );
  }

  IconData _resolveIcon(String categoryId) {
    switch (categoryId) {
      case 'flutter':
        return Icons.flutter_dash_rounded;
      case 'dart':
        return Icons.code_rounded;
      case 'android':
        return Icons.android_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  double _resolveProgress(int questionCount) {
    final double value = questionCount / 100;
    if (value < 0.05) {
      return 0.05;
    }
    if (value > 1) {
      return 1;
    }
    return value;
  }

  void _showAllCategoriesSheet(
    BuildContext context,
    List<Category> data,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => _AllCategoriesSheet(
        categories: data,
        onCategoryTap: (Category category) => context.push(
          '/category',
          extra: <String, dynamic>{
            'topicId': category.id,
            'topicName': category.title,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppSectionHeader(
          title: context.l10n.homeCategoriesTitle,
          actionLabel: context.l10n.homeSeeAll,
          onActionTap: () => _showAllCategoriesSheet(context, categories),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          itemCount: _previewCategories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.12,
          ),
          itemBuilder: (BuildContext context, int index) {
            final Category item = _previewCategories[index];
            final Color iconColor = Color(item.colorValue);
            return AppCategoryCard(
              title: item.title,
              solvedCount: (item.questionCount * 0.3).round(),
              totalCount: item.questionCount,
              progress: _resolveProgress(item.questionCount),
              icon: Icon(_resolveIcon(item.id)),
              iconColor: iconColor,
              iconBackgroundColor: _resolveBackgroundColor(iconColor),
              onTap: () => context.push(
                '/category',
                extra: <String, dynamic>{
                  'topicId': item.id,
                  'topicName': item.title,
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AllCategoriesSheet extends StatelessWidget {
  const _AllCategoriesSheet({
    required this.categories,
    required this.onCategoryTap,
  });

  final List<Category> categories;
  final ValueChanged<Category> onCategoryTap;

  Color _resolveBackgroundColor(Color color) {
    return Color.alphaBlend(
      color.withValues(alpha: 0.18),
      Colors.white,
    );
  }

  IconData _resolveIcon(String categoryId) {
    switch (categoryId) {
      case 'flutter':
        return Icons.flutter_dash_rounded;
      case 'dart':
        return Icons.code_rounded;
      case 'android':
        return Icons.android_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  double _resolveProgress(int questionCount) {
    final double value = questionCount / 100;
    if (value < 0.05) {
      return 0.05;
    }
    if (value > 1) {
      return 1;
    }
    return value;
  }

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
                  context.l10n.homeAllCategoriesTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: NeutralColor.neutral900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.l10n.homeAllCategoriesSubtitle,
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
                      final Category item = categories[index];
                      final Color iconColor = Color(item.colorValue);
                      return AppCategoryCard(
                        title: item.title,
                        solvedCount: (item.questionCount * 0.3).round(),
                        totalCount: item.questionCount,
                        progress: _resolveProgress(item.questionCount),
                        icon: Icon(_resolveIcon(item.id)),
                        iconColor: iconColor,
                        iconBackgroundColor: _resolveBackgroundColor(iconColor),
                        onTap: () {
                          Navigator.of(context).pop();
                          onCategoryTap(item);
                        },
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
