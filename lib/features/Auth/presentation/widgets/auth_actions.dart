import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/core/widgets/small_button_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class AuthActions extends StatelessWidget {
  const AuthActions({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthState state = context.watch<AuthBloc>().state;

    return Column(
      children: <Widget>[
        SizedBox(
          height: 52,
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: state.isLoading
                ? null
                : () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthSignInWithGoogleRequested());
                  },
            icon: state.isLoading ? const SmallButtonLoader() : const _GoogleMark(),
            label: Text(
              AppStrings.authGoogleContinue,
              style: context.labelLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: NeutralColor.neutral900,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: BasicColor.white,
              side: const BorderSide(color: NeutralColor.neutral200),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        10.h,
        Text(
          AppStrings.authFreeNote,
          textAlign: TextAlign.center,
          style: context.bodySmall.copyWith(color: NeutralColor.neutral400),
        ),
      ],
    );
  }
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: BasicColor.white,
        shape: BoxShape.circle,
        border: Border.all(color: NeutralColor.neutral300),
      ),
      alignment: Alignment.center,
      child: Text(
        'G',
        style: context.labelMedium.copyWith(
          color: PrimaryColor.primary600,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
