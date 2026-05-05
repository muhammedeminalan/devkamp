import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/features/auth/presentation/sections/auth_actions.dart';
import 'package:app/features/auth/presentation/sections/auth_illustration.dart';
import 'package:app/features/auth/presentation/sections/auth_title_section.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (AuthState previous, AuthState current) {
        return previous.errorMessage != current.errorMessage &&
            current.errorMessage != null;
      },
      listener: (BuildContext context, AuthState state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 80, 28, 48),
            child: Column(
              children: <Widget>[
                12.h,
                const Center(child: AuthIllustration()),
                const Expanded(child: AuthTitleSection()),
                const AuthActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
