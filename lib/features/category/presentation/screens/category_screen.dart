import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/category/domain/entities/study_category.dart';
import 'package:app/features/category/presentation/bloc/category_bloc.dart';
import 'package:app/features/category/presentation/bloc/category_event.dart';
import 'package:app/features/category/presentation/bloc/category_state.dart';
import 'package:app/features/category/presentation/sections/category_generating_section.dart';
import 'package:app/features/category/presentation/sections/category_list_section.dart';
import 'package:app/core/widgets/states/app_error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

// Bir topic'e ait AI üretimi kategorileri listeleyen ekran.
// Firestore'da yoksa otomatik olarak Gemini ile üretilir.
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    required this.topicId,
    required this.topicName,
    super.key,
  });

  final String topicId;
  final String topicName;

  @override
  Widget build(BuildContext context) {
    final String userId =
        context.read<AuthBloc>().state.user?.id ?? '';

    return BlocProvider<CategoryBloc>(
      // DI, CategoryBloc bağımlılıklarını otomatik çözer.
      create: (_) => GetIt.instance<CategoryBloc>()..add(CategoriesLoadRequested(
          topicId: topicId,
          topicName: topicName,
          userId: userId,
        )),
      child: _CategoryBody(topicId: topicId, topicName: topicName),
    );
  }
}

class _CategoryBody extends StatelessWidget {
  const _CategoryBody({
    required this.topicId,
    required this.topicName,
  });

  final String topicId;
  final String topicName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          topicName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: NeutralColor.neutral900,
              ),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (BuildContext context, CategoryState state) {
          if (state.status == CategoryBlocStatus.loading ||
              state.status == CategoryBlocStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == CategoryBlocStatus.generating) {
            return const SingleChildScrollView(
              child: CategoryGeneratingSection(),
            );
          }

          if (state.status == CategoryBlocStatus.error) {
            return AppErrorState(
              message: state.errorMessage ?? 'Kategoriler yüklenemedi.',
              actionLabel: context.l10n.categoryRetry,
              onAction: () {
                final String userId =
                    context.read<AuthBloc>().state.user?.id ?? '';
                context.read<CategoryBloc>().add(CategoriesLoadRequested(
                      topicId: topicId,
                      topicName: topicName,
                      userId: userId,
                    ));
              },
            );
          }

          if (state.categories.isEmpty) {
            return Center(
              child: Text(context.l10n.categoryNotFound),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                child: Text(
                  '${state.categories.length} konu hazır',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: NeutralColor.neutral500,
                      ),
                ),
              ),
              Expanded(
                child: CategoryListSection(
                  categories: state.categories,
                  onCategoryTap: (StudyCategory category) => context.push(
                    '/quiz',
                    extra: <String, dynamic>{
                      'categoryId': category.id,
                      'topicId': topicId,
                      'topicName': category.name,
                      'categoryName': category.name,
                      'isRandom': false,
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          '/quiz',
          extra: <String, dynamic>{
            'categoryId': topicId,
            'topicId': topicId,
            'topicName': context.l10n.categoryRandomQuiz,
            'categoryName': topicName,
            'isRandom': true,
          },
        ),
        backgroundColor: PrimaryColor.primary600,
        icon: const Icon(Icons.bolt_rounded, color: Colors.white),
        label: Text(
          context.l10n.categoryRandomQuiz,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
