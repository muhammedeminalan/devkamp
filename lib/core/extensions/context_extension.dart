import 'package:app/config/theme/constants/app_text_styles.dart';
import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/error_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/config/theme/constants/color/success_color.dart';
import 'package:app/config/theme/constants/color/warning_color.dart';
import 'package:app/core/constants/ui/gaps.dart';
import 'package:app/core/constants/ui/padding_values.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primaryColor => colorScheme.primary;
  Color get errorColor => colorScheme.error;
  Color get surfaceColor => colorScheme.surface;
  Color get notImplementedColor => Colors.deepPurple;

  Color get basicWhite => BasicColor.white;
  Color get basicBlack => BasicColor.black;
  Color get transparentColor => BasicColor.transparent;
  Color get codeBgColor => BasicColor.codeBg;
  Color get codeInkColor => BasicColor.codeInk;

  Color get error50 => ErrorColor.error50;
  Color get error100 => ErrorColor.error100;
  Color get error200 => ErrorColor.error200;
  Color get error300 => ErrorColor.error300;
  Color get error400 => ErrorColor.error400;
  Color get error500 => ErrorColor.error500;
  Color get error600 => ErrorColor.error600;
  Color get error700 => ErrorColor.error700;
  Color get error800 => ErrorColor.error800;
  Color get error900 => ErrorColor.error900;
  Color get error950 => ErrorColor.error950;

  Color get neutral50 => NeutralColor.neutral50;
  Color get neutral100 => NeutralColor.neutral100;
  Color get neutral200 => NeutralColor.neutral200;
  Color get neutral300 => NeutralColor.neutral300;
  Color get neutral400 => NeutralColor.neutral400;
  Color get neutral500 => NeutralColor.neutral500;
  Color get neutral600 => NeutralColor.neutral600;
  Color get neutral700 => NeutralColor.neutral700;
  Color get neutral800 => NeutralColor.neutral800;
  Color get neutral900 => NeutralColor.neutral900;
  Color get neutral950 => NeutralColor.neutral950;

  Color get primary50 => PrimaryColor.primary50;
  Color get primary100 => PrimaryColor.primary100;
  Color get primary200 => PrimaryColor.primary200;
  Color get primary300 => PrimaryColor.primary300;
  Color get primary400 => PrimaryColor.primary400;
  Color get primary500 => PrimaryColor.primary500;
  Color get primary600 => PrimaryColor.primary600;
  Color get primary700 => PrimaryColor.primary700;
  Color get primary800 => PrimaryColor.primary800;
  Color get primary900 => PrimaryColor.primary900;
  Color get primary950 => PrimaryColor.primary950;

  Color get success50 => SuccessColor.success50;
  Color get success100 => SuccessColor.success100;
  Color get success200 => SuccessColor.success200;
  Color get success300 => SuccessColor.success300;
  Color get success400 => SuccessColor.success400;
  Color get success500 => SuccessColor.success500;
  Color get success600 => SuccessColor.success600;
  Color get success700 => SuccessColor.success700;
  Color get success800 => SuccessColor.success800;
  Color get success900 => SuccessColor.success900;
  Color get success950 => SuccessColor.success950;

  Color get warning50 => WarningColor.warning50;
  Color get warning100 => WarningColor.warning100;
  Color get warning200 => WarningColor.warning200;
  Color get warning300 => WarningColor.warning300;
  Color get warning400 => WarningColor.warning400;
  Color get warning500 => WarningColor.warning500;
  Color get warning600 => WarningColor.warning600;
  Color get warning700 => WarningColor.warning700;
  Color get warning800 => WarningColor.warning800;
  Color get warning900 => WarningColor.warning900;
  Color get warning950 => WarningColor.warning950;

  TextStyle get displayLarge => AppTextStyles.displayLarge;
  TextStyle get displayMedium => AppTextStyles.displayMedium;
  TextStyle get displaySmall => AppTextStyles.displaySmall;
  TextStyle get headlineLarge => AppTextStyles.headlineLarge;
  TextStyle get headlineMedium => AppTextStyles.headlineMedium;
  TextStyle get headlineSmall => AppTextStyles.headlineSmall;
  TextStyle get titleLarge => AppTextStyles.titleLarge;
  TextStyle get titleMedium => AppTextStyles.titleMedium;
  TextStyle get titleSmall => AppTextStyles.titleSmall;
  TextStyle get labelLarge => AppTextStyles.labelLarge;
  TextStyle get labelMedium => AppTextStyles.labelMedium;
  TextStyle get labelSmall => AppTextStyles.labelSmall;
  TextStyle get bodyLarge => AppTextStyles.bodyLarge;
  TextStyle get bodyMedium => AppTextStyles.bodyMedium;
  TextStyle get bodySmall => AppTextStyles.bodySmall;

  SizedBox get extraSmallHorizontalGap => Gaps.extraSmallHorizontal;
  SizedBox get smallHorizontalGap => Gaps.smallHorizontal;
  SizedBox get mediumHorizontalGap => Gaps.mediumHorizontal;
  SizedBox get normalHorizontalGap => Gaps.normalHorizontal;
  SizedBox get largeHorizontalGap => Gaps.largeHorizontal;
  SizedBox get extraLargeHorizontalGap => Gaps.extraLargeHorizontal;

  SizedBox get extraSmallVerticalGap => Gaps.extraSmallVertical;
  SizedBox get smallVerticalGap => Gaps.smallVertical;
  SizedBox get mediumVerticalGap => Gaps.mediumVertical;
  SizedBox get normalVerticalGap => Gaps.normalVertical;
  SizedBox get largeVerticalGap => Gaps.largeVertical;
  SizedBox get extraLargeVerticalGap => Gaps.extraLargeVertical;

  double get extraSmallPadding => PaddingValues.extraSmallPadding;
  double get smallPadding => PaddingValues.smallPadding;
  double get mediumPadding => PaddingValues.mediumPadding;
  double get normalPadding => PaddingValues.normalPadding;
  double get largePadding => PaddingValues.largePadding;
  double get extraLargePadding => PaddingValues.extraLargePadding;

  Divider get divider => const Divider(color: NeutralColor.neutral100);
}
