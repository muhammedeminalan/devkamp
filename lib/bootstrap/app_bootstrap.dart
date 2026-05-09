import 'package:app/app/dev_kamp_app.dart';
import 'package:app/config/di/injection_container.dart';
import 'package:app/config/router/app_router.dart';
import 'package:app/core/locale/locale_cubit.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<AuthBloc>.value(value: sl<AuthBloc>()),
        // LocaleCubit uygulama seviyesinde yaşar; herhangi bir yerden erişilebilir.
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
      ],
      child: DevKampApp(router: sl<AppRouter>().router),
    );
  }
}
