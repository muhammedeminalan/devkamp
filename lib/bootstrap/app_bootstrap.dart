import 'package:app/app/dev_kamp_app.dart';
import 'package:app/config/router/app_router.dart';
import 'package:app/config/di/injection_container.dart';
import 'package:app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: sl<AuthBloc>(),
      child: DevKampApp(router: sl<AppRouter>().router),
    );
  }
}
