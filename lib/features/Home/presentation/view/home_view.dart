import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:app/sub_features/home/home_categories_section.dart';
import 'package:app/sub_features/home/home_continue_section.dart';
import 'package:app/sub_features/home/home_header_section.dart';
import 'package:app/sub_features/home/home_progress_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthState authState = context.watch<AuthBloc>().state;
    final String userName =
        authState.user?.name ?? AppStrings.homeFallbackUserName;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HomeHeaderSection(userName: userName),
                16.h,
                const HomeProgressSection(),
                24.h,
                const HomeContinueSection(),
                24.h,
                const HomeCategoriesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
