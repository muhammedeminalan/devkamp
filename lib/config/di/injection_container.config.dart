// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/firebase_auth_repository.dart'
    as _i900;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/check_session_usecase.dart'
    as _i1011;
import '../../features/auth/domain/usecases/sign_in_with_email_usecase.dart'
    as _i744;
import '../../features/auth/domain/usecases/sign_in_with_google_usecase.dart'
    as _i673;
import '../../features/auth/domain/usecases/sign_out_usecase.dart' as _i915;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/home/data/repositories/fake_home_repository.dart'
    as _i568;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/usecases/get_categories_usecase.dart'
    as _i967;
import '../../features/home/domain/usecases/get_progress_usecase.dart' as _i557;
import '../../features/profile/data/repositories/fake_profile_repository.dart'
    as _i850;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/get_user_stats_usecase.dart'
    as _i349;
import '../../features/quiz/data/repositories/fake_quiz_repository.dart'
    as _i196;
import '../../features/quiz/domain/repositories/quiz_repository.dart' as _i613;
import '../../features/quiz/domain/usecases/get_ai_answer_usecase.dart'
    as _i892;
import '../../features/quiz/domain/usecases/get_quiz_questions_usecase.dart'
    as _i650;
import '../../features/saved/data/repositories/fake_saved_repository.dart'
    as _i671;
import '../../features/saved/domain/repositories/saved_repository.dart'
    as _i105;
import '../../features/saved/domain/usecases/get_saved_questions_usecase.dart'
    as _i599;
import '../../features/saved/domain/usecases/remove_saved_question_usecase.dart'
    as _i575;
import '../../features/topic/data/repositories/fake_topic_repository.dart'
    as _i1012;
import '../../features/topic/domain/repositories/topic_repository.dart'
    as _i1062;
import '../../features/topic/domain/usecases/get_topics_usecase.dart' as _i652;
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
    gh.lazySingleton<_i613.QuizRepository>(() => _i196.FakeQuizRepository());
    gh.lazySingleton<_i894.ProfileRepository>(
        () => _i850.FakeProfileRepository());
    gh.lazySingleton<_i105.SavedRepository>(() => _i671.FakeSavedRepository());
    gh.lazySingleton<_i1062.TopicRepository>(
        () => _i1012.FakeTopicRepository());
    gh.lazySingleton<_i892.GetAiAnswerUseCase>(
        () => _i892.GetAiAnswerUseCase(gh<_i613.QuizRepository>()));
    gh.lazySingleton<_i650.GetQuizQuestionsUseCase>(
        () => _i650.GetQuizQuestionsUseCase(gh<_i613.QuizRepository>()));
    gh.lazySingleton<_i161.AuthRemoteDataSource>(
        () => _i161.FirebaseAuthRemoteDataSource());
    gh.lazySingleton<_i787.AuthRepository>(() => _i900.FirebaseAuthRepository(
        remoteDataSource: gh<_i161.AuthRemoteDataSource>()));
    gh.lazySingleton<_i652.GetTopicsUseCase>(
        () => _i652.GetTopicsUseCase(gh<_i1062.TopicRepository>()));
    gh.lazySingleton<_i0.HomeRepository>(() => _i568.FakeHomeRepository());
    gh.lazySingleton<_i1011.CheckSessionUseCase>(
        () => _i1011.CheckSessionUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i744.SignInWithEmailUseCase>(
        () => _i744.SignInWithEmailUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i673.SignInWithGoogleUseCase>(
        () => _i673.SignInWithGoogleUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i915.SignOutUseCase>(
        () => _i915.SignOutUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i349.GetUserStatsUseCase>(
        () => _i349.GetUserStatsUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i349.GetAchievementsUseCase>(
        () => _i349.GetAchievementsUseCase(gh<_i894.ProfileRepository>()));
    gh.lazySingleton<_i599.GetSavedQuestionsUseCase>(
        () => _i599.GetSavedQuestionsUseCase(gh<_i105.SavedRepository>()));
    gh.lazySingleton<_i575.RemoveSavedQuestionUseCase>(
        () => _i575.RemoveSavedQuestionUseCase(gh<_i105.SavedRepository>()));
    await gh.factoryAsync<_i797.AuthBloc>(
      () => appModule.authBloc(
        gh<_i1011.CheckSessionUseCase>(),
        gh<_i673.SignInWithGoogleUseCase>(),
        gh<_i744.SignInWithEmailUseCase>(),
        gh<_i915.SignOutUseCase>(),
        gh<_i787.AuthRepository>(),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i967.GetCategoriesUseCase>(
        () => _i967.GetCategoriesUseCase(gh<_i0.HomeRepository>()));
    gh.lazySingleton<_i557.GetProgressUseCase>(
        () => _i557.GetProgressUseCase(gh<_i0.HomeRepository>()));
    gh.lazySingleton<_i81.AppRouter>(
        () => appModule.appRouter(gh<_i797.AuthBloc>()));
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
