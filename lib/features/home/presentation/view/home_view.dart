import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:app/features/home/domain/usecases/get_progress_usecase.dart';
import 'package:app/features/home/presentation/bloc/home_bloc.dart';
import 'package:app/features/home/presentation/bloc/home_event.dart';
import 'package:app/features/home/presentation/bloc/home_state.dart';
import 'package:app/features/home/presentation/sections/home_categories_section.dart';
import 'package:app/features/home/presentation/sections/home_continue_section.dart';
import 'package:app/features/home/presentation/sections/home_header_section.dart';
import 'package:app/features/home/presentation/sections/home_progress_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(
        getCategoriesUseCase: GetIt.instance<GetCategoriesUseCase>(),
        getProgressUseCase: GetIt.instance<GetProgressUseCase>(),
      )..add(const HomeDataLoaded()),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final AuthState authState = context.watch<AuthBloc>().state;
    final String userName =
        authState.user?.name ?? AppStrings.homeFallbackUserName;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            if (state.status == HomeStatus.loading ||
                state.status == HomeStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == HomeStatus.failure || state.progress == null) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'Home verileri yüklenemedi.',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HomeHeaderSection(userName: userName),
                    16.h,
                    HomeProgressSection(progress: state.progress!),
                    24.h,
                    const HomeContinueSection(),
                    24.h,
                    HomeCategoriesSection(categories: state.categories),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
