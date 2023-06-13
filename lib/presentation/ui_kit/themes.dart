import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class AppTheme {
  static final TextTheme _lightTextTheme = TextTheme(
    headlineLarge: AppTextStyle.largeTitle.copyWith(
      color: AppThemeColors.light.labelPrimary,
    ),
    headlineMedium: AppTextStyle.title.copyWith(
      color: AppThemeColors.light.labelPrimary,
    ),
    titleMedium: AppTextStyle.button.copyWith(
      color: AppThemeColors.light.labelPrimary,
    ),
    bodyMedium: AppTextStyle.body.copyWith(
      color: AppThemeColors.light.labelPrimary,
    ),
    bodySmall: AppTextStyle.subhead.copyWith(
      color: AppThemeColors.light.labelPrimary,
    ),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headlineLarge: AppTextStyle.largeTitle.copyWith(
      color: AppThemeColors.dark.labelPrimary,
    ),
    headlineMedium: AppTextStyle.title.copyWith(
      color: AppThemeColors.dark.labelPrimary,
    ),
    titleMedium: AppTextStyle.button.copyWith(
      color: AppThemeColors.dark.labelPrimary,
    ),
    bodyMedium: AppTextStyle.body.copyWith(
      color: AppThemeColors.dark.labelPrimary,
    ),
    bodySmall: AppTextStyle.subhead.copyWith(
      color: AppThemeColors.dark.labelPrimary,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: InkRipple.splashFactory,
    useMaterial3: false,
    primaryTextTheme: _lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    useMaterial3: false,
    primaryTextTheme: _darkTextTheme,
  );

  AppTheme();
}
