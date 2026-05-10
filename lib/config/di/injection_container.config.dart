// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_generative_ai/google_generative_ai.dart' as _i656;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/locale/locale_cubit.dart' as _i142;
import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/firebase_auth_repository.dart'
    as _i900;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/check_session_usecase.dart'
    as _i1011;
import '../../features/auth/domain/usecases/sign_in_with_google_usecase.dart'
    as _i673;
import '../../features/auth/domain/usecases/sign_out_usecase.dart' as _i915;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/category/data/repositories/firestore_category_repository.dart'
    as _i990;
import '../../features/category/domain/repositories/category_repository.dart'
    as _i869;
import '../../features/category/domain/usecases/generate_categories_usecase.dart'
    as _i487;
import '../../features/category/domain/usecases/get_categories_usecase.dart'
    as _i125;
import '../../features/category/domain/usecases/watch_category_usecase.dart'
    as _i835;
import '../../features/category/presentation/bloc/category_bloc.dart' as _i292;
import '../../features/home/data/repositories/firestore_home_repository.dart'
    as _i884;
import '../../features/home/data/repositories/firestore_last_session_repository.dart'
    as _i167;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/repositories/last_session_repository.dart'
    as _i939;
import '../../features/home/domain/usecases/get_categories_usecase.dart'
    as _i967;
import '../../features/home/domain/usecases/get_last_session_usecase.dart'
    as _i963;
import '../../features/home/domain/usecases/get_progress_usecase.dart' as _i557;
import '../../features/home/domain/usecases/save_last_session_usecase.dart'
    as _i769;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/profile/data/repositories/firestore_profile_repository.dart'
    as _i973;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/get_achievements_usecase.dart'
    as _i123;
import '../../features/profile/domain/usecases/get_category_performance_usecase.dart'
    as _i834;
import '../../features/profile/domain/usecases/get_user_stats_usecase.dart'
    as _i349;
import '../../features/profile/domain/usecases/update_streak_usecase.dart'
    as _i2;
import '../../features/profile/presentation/bloc/profile_bloc.dart' as _i469;
import '../../features/quiz/data/repositories/firebase_quiz_repository.dart'
    as _i1005;
import '../../features/quiz/data/repositories/firestore_question_repository.dart'
    as _i92;
import '../../features/quiz/domain/repositories/quiz_repository.dart' as _i613;
import '../../features/quiz/domain/usecases/generate_questions_usecase.dart'
    as _i764;
import '../../features/quiz/domain/usecases/get_ai_answer_usecase.dart'
    as _i892;
import '../../features/quiz/domain/usecases/get_quiz_questions_usecase.dart'
    as _i650;
import '../../features/quiz/presentation/bloc/quiz_bloc.dart' as _i505;
import '../../features/saved/data/repositories/firestore_saved_repository.dart'
    as _i1011;
import '../../features/saved/domain/repositories/saved_repository.dart'
    as _i105;
import '../../features/saved/domain/usecases/get_saved_questions_usecase.dart'
    as _i599;
import '../../features/saved/domain/usecases/remove_saved_question_usecase.dart'
    as _i575;
import '../../features/saved/domain/usecases/save_question_usecase.dart'
    as _i426;
import '../../features/saved/presentation/bloc/saved_bloc.dart' as _i88;
import '../../features/topic/data/repositories/firestore_topic_repository.dart'
    as _i34;
import '../../features/topic/domain/repositories/topic_repository.dart'
    as _i1062;
import '../../features/topic/domain/usecases/get_topics_usecase.dart' as _i652;
import '../../features/topic/presentation/bloc/topic_bloc.dart' as _i1037;
import '../router/app_router.dart' as _i81;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i974.FirebaseFirestore>(() => appModule.firestore);
    gh.lazySingleton<_i656.GenerativeModel>(() => appModule.geminiModel());
    gh.lazySingleton<_i142.LocaleCubit>(() => _i142.LocaleCubit());
    gh.lazySingleton<_i869.CategoryRepository>(
        () => _i990.FirestoreCategoryRepository(
              gh<_i974.FirebaseFirestore>(),
              gh<_i656.GenerativeModel>(),
            ));
    gh.lazySingleton<_i92.FirestoreQuestionRepository>(
        () => _i92.FirestoreQuestionRepository(
              gh<_i974.FirebaseFirestore>(),
              gh<_i656.GenerativeModel>(),
            ));
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
        () => _i161.FirebaseAuthRemoteDataSource());
    gh.lazySingleton<_i787.AuthRepository>(() => _i900.FirebaseAuthRepository(
        remoteDataSource: gh<_i161.AuthRemoteDataSource>()));
    gh.lazySingleton<_i1011.CheckSessionUseCase>(
        () => _i1011.CheckSessionUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i673.SignInWithGoogleUseCase>(
        () => _i673.SignInWithGoogleUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i915.SignOutUseCase>(
        () => _i915.SignOutUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i894.ProfileRepository>(
        () => _i973.FirestoreProfileRepository(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i0.HomeRepository>(
        () => _i884.FirestoreHomeRepository(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i123.GetAchievementsUseCase>(
        () => _i123.GetAchievementsUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i834.GetCategoryPerformanceUseCase>(() =>
        _i834.GetCategoryPerformanceUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i349.GetUserStatsUseCase>(
        () => _i349.GetUserStatsUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i2.UpdateStreakUseCase>(
        () => _i2.UpdateStreakUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i105.SavedRepository>(
        () => _i1011.FirestoreSavedRepository(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i599.GetSavedQuestionsUseCase>(
        () => _i599.GetSavedQuestionsUseCase(gh<_i105.SavedRepository>()));
    gh.lazySingleton<_i575.RemoveSavedQuestionUseCase>(
        () => _i575.RemoveSavedQuestionUseCase(gh<_i105.SavedRepository>()));
    gh.lazySingleton<_i426.SaveQuestionUseCase>(
        () => _i426.SaveQuestionUseCase(gh<_i105.SavedRepository>()));
    gh.lazySingleton<_i487.GenerateCategoriesUseCase>(
        () => _i487.GenerateCategoriesUseCase(gh<_i869.CategoryRepository>()));
    gh.lazySingleton<_i125.GetCategoriesUseCase>(
        () => _i125.GetCategoriesUseCase(gh<_i869.CategoryRepository>()));
    gh.lazySingleton<_i835.WatchCategoryUseCase>(
        () => _i835.WatchCategoryUseCase(gh<_i869.CategoryRepository>()));
    gh.lazySingleton<_i939.LastSessionRepository>(() =>
        _i167.FirestoreLastSessionRepository(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i967.GetCategoriesUseCase>(
        () => _i967.GetCategoriesUseCase(gh<_i0.HomeRepository>()));
    gh.lazySingleton<_i557.GetProgressUseCase>(
        () => _i557.GetProgressUseCase(gh<_i0.HomeRepository>()));
    gh.lazySingleton<_i963.GetLastSessionUseCase>(
        () => _i963.GetLastSessionUseCase(gh<_i939.LastSessionRepository>()));
    gh.lazySingleton<_i769.SaveLastSessionUseCase>(
        () => _i769.SaveLastSessionUseCase(gh<_i939.LastSessionRepository>()));
    gh.factory<_i88.SavedBloc>(() => _i88.SavedBloc(
          getSavedQuestionsUseCase: gh<_i599.GetSavedQuestionsUseCase>(),
          removeSavedQuestionUseCase: gh<_i575.RemoveSavedQuestionUseCase>(),
        ));
    gh.lazySingleton<_i1062.TopicRepository>(
        () => _i34.FirestoreTopicRepository(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i292.CategoryBloc>(() => _i292.CategoryBloc(
          getCategoriesUseCase: gh<_i125.GetCategoriesUseCase>(),
          generateCategoriesUseCase: gh<_i487.GenerateCategoriesUseCase>(),
        ));
    gh.lazySingleton<_i613.QuizRepository>(() => _i1005.GeminiQuizRepository(
          gh<_i974.FirebaseFirestore>(),
          gh<_i92.FirestoreQuestionRepository>(),
        ));
    gh.lazySingleton<_i652.GetTopicsUseCase>(
        () => _i652.GetTopicsUseCase(gh<_i1062.TopicRepository>()));
    gh.factory<_i469.ProfileBloc>(() => _i469.ProfileBloc(
          getUserStatsUseCase: gh<_i349.GetUserStatsUseCase>(),
          getAchievementsUseCase: gh<_i123.GetAchievementsUseCase>(),
          getCategoryPerformanceUseCase:
              gh<_i834.GetCategoryPerformanceUseCase>(),
        ));
    await gh.factoryAsync<_i797.AuthBloc>(
      () => appModule.authBloc(
        gh<_i1011.CheckSessionUseCase>(),
        gh<_i673.SignInWithGoogleUseCase>(),
        gh<_i915.SignOutUseCase>(),
        gh<_i787.AuthRepository>(),
        gh<_i2.UpdateStreakUseCase>(),
      ),
      preResolve: true,
    );
    gh.factory<_i202.HomeBloc>(() => _i202.HomeBloc(
          getCategoriesUseCase: gh<_i967.GetCategoriesUseCase>(),
          getProgressUseCase: gh<_i557.GetProgressUseCase>(),
          getLastSessionUseCase: gh<_i963.GetLastSessionUseCase>(),
        ));
    gh.factory<_i1037.TopicBloc>(
        () => _i1037.TopicBloc(getTopicsUseCase: gh<_i652.GetTopicsUseCase>()));
    gh.lazySingleton<_i764.GenerateQuestionsUseCase>(
        () => _i764.GenerateQuestionsUseCase(gh<_i613.QuizRepository>()));
    gh.lazySingleton<_i892.GetAiAnswerUseCase>(
        () => _i892.GetAiAnswerUseCase(gh<_i613.QuizRepository>()));
    gh.lazySingleton<_i650.GetQuizQuestionsUseCase>(
        () => _i650.GetQuizQuestionsUseCase(gh<_i613.QuizRepository>()));
    gh.lazySingleton<_i81.AppRouter>(
        () => appModule.appRouter(gh<_i797.AuthBloc>()));
    gh.factory<_i505.QuizBloc>(() => _i505.QuizBloc(
          getQuizQuestionsUseCase: gh<_i650.GetQuizQuestionsUseCase>(),
          getAiAnswerUseCase: gh<_i892.GetAiAnswerUseCase>(),
          generateQuestionsUseCase: gh<_i764.GenerateQuestionsUseCase>(),
          saveQuestionUseCase: gh<_i426.SaveQuestionUseCase>(),
          removeSavedQuestionUseCase: gh<_i575.RemoveSavedQuestionUseCase>(),
          saveLastSessionUseCase: gh<_i769.SaveLastSessionUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
