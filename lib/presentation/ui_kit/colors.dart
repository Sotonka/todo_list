import 'package:flutter/material.dart';

class AppColors {
  // light theme
  static const Color supportSeparatorTL = Color(0x33000000);
  static const Color supportOverlayTL = Color(0x0F000000);
  static const Color labelPrimaryTL = Color(0xFF000000);
  static const Color labelSecondaryTL = Color(0x99000000);
  static const Color labelTetriaryTL = Color(0x4D000000);
  static const Color labelDisableTL = Color(0x26000000);
  static const Color redTL = Color(0xFFFF3B30);
  static const Color greenTL = Color(0xFF34C759);
  static const Color blueTL = Color(0xFF007AFF);
  static const Color grayTL = Color(0xFF8E8E93);
  static const Color grayLightTL = Color(0xFFD1D1D6);
  static const Color whiteTL = Color(0xFFFFFFFF);
  static const Color backPrimaryTL = Color(0xFFF7F6F2);
  static const Color backSecondaryTL = Color(0xFFFFFFFF);
  static const Color backElevatedTL = Color(0xFFFFFFFF);

  // dark theme
  static const Color supportSeparatorTD = Color(0x33FFFFFF);
  static const Color supportOverlayTD = Color(0x52000000);
  static const Color labelPrimaryTD = Color(0xFFFFFFFF);
  static const Color labelSecondaryTD = Color(0x99FFFFFF);
  static const Color labelTetriaryTD = Color(0x66FFFFFF);
  static const Color labelDisableTD = Color(0x26FFFFFF);
  static const Color redTD = Color(0xFFFF453A);
  static const Color greenTD = Color(0xFF32D74B);
  static const Color blueTD = Color(0xFF0A84FF);
  static const Color grayTD = Color(0xFF8E8E93);
  static const Color grayLightTD = Color(0xFF48484A);
  static const Color whiteTD = Color(0xFFFFFFFF);
  static const Color backPrimaryTD = Color(0xFF161618);
  static const Color backSecondaryTD = Color(0xFF252528);
  static const Color backElevatedTD = Color(0xFF3C3C3F);

  const AppColors._();
}

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  static const light = AppThemeColors(
    supportSeparator: Color(0x33000000),
    supportOverlay: Color(0x0F000000),
    labelPrimary: Color(0xFF000000),
    labelSecondary: Color(0x99000000),
    labelTetriary: Color(0x4D000000),
    labelDisable: Color(0x26000000),
    red: Color(0xFFFF3B30),
    green: Color(0xFF34C759),
    blue: Color(0xFF007AFF),
    gray: Color(0xFF8E8E93),
    grayLight: Color(0xFFD1D1D6),
    white: Color(0xFFFFFFFF),
    backPrimary: Color(0xFFF7F6F2),
    backSecondary: Color(0xFFFFFFFF),
    backElevated: Color(0xFFFFFFFF),
  );

  static const dark = AppThemeColors(
    supportSeparator: Color(0x33FFFFFF),
    supportOverlay: Color(0x52000000),
    labelPrimary: Color(0xFFFFFFFF),
    labelSecondary: Color(0x99FFFFFF),
    labelTetriary: Color(0x66FFFFFF),
    labelDisable: Color(0x26FFFFFF),
    red: Color(0xFFFF453A),
    green: Color(0xFF32D74B),
    blue: Color(0xFF0A84FF),
    gray: Color(0xFF8E8E93),
    grayLight: Color(0xFF48484A),
    white: Color(0xFFFFFFFF),
    backPrimary: Color(0xFF161618),
    backSecondary: Color(0xFF252528),
    backElevated: Color(0xFF3C3C3F),
  );

  final Color? supportSeparator;
  final Color? supportOverlay;
  final Color? labelPrimary;
  final Color? labelSecondary;
  final Color? labelTetriary;
  final Color? labelDisable;
  final Color? red;
  final Color? green;
  final Color? blue;
  final Color? gray;
  final Color? grayLight;
  final Color? white;
  final Color? backPrimary;
  final Color? backSecondary;
  final Color? backElevated;

  const AppThemeColors({
    required this.supportSeparator,
    required this.supportOverlay,
    required this.labelPrimary,
    required this.labelSecondary,
    required this.labelTetriary,
    required this.labelDisable,
    required this.red,
    required this.green,
    required this.blue,
    required this.gray,
    required this.grayLight,
    required this.white,
    required this.backPrimary,
    required this.backSecondary,
    required this.backElevated,
  });

  @override
  AppThemeColors copyWith({
    Color? supportSeparator,
    Color? supportOverlay,
    Color? labelPrimary,
    Color? labelSecondary,
    Color? labelTetriary,
    Color? labelDisable,
    Color? red,
    Color? green,
    Color? blue,
    Color? gray,
    Color? grayLight,
    Color? white,
    Color? backPrimary,
    Color? backSecondary,
    Color? backElevated,
  }) {
    return AppThemeColors(
      supportSeparator: supportSeparator ?? this.supportSeparator,
      supportOverlay: supportOverlay ?? this.supportOverlay,
      labelPrimary: labelPrimary ?? this.labelPrimary,
      labelSecondary: labelSecondary ?? this.labelSecondary,
      labelTetriary: labelTetriary ?? this.labelTetriary,
      labelDisable: labelDisable ?? this.labelDisable,
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
      gray: gray ?? this.gray,
      grayLight: grayLight ?? this.grayLight,
      white: white ?? this.white,
      backPrimary: backPrimary ?? this.backPrimary,
      backSecondary: backSecondary ?? this.backSecondary,
      backElevated: backElevated ?? this.backElevated,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) {
      return this;
    }

    return AppThemeColors(
      supportSeparator: Color.lerp(supportSeparator, other.supportSeparator, t),
      supportOverlay: Color.lerp(supportOverlay, other.supportOverlay, t),
      labelPrimary: Color.lerp(labelPrimary, other.labelPrimary, t),
      labelSecondary: Color.lerp(labelSecondary, other.labelSecondary, t),
      labelTetriary: Color.lerp(labelTetriary, other.labelTetriary, t),
      labelDisable: Color.lerp(labelDisable, other.labelDisable, t),
      red: Color.lerp(red, other.red, t),
      green: Color.lerp(green, other.green, t),
      blue: Color.lerp(blue, other.blue, t),
      gray: Color.lerp(gray, other.gray, t),
      grayLight: Color.lerp(grayLight, other.grayLight, t),
      white: Color.lerp(white, other.white, t),
      backPrimary: Color.lerp(backPrimary, other.backPrimary, t),
      backSecondary: Color.lerp(backSecondary, other.backSecondary, t),
      backElevated: Color.lerp(backElevated, other.backElevated, t),
    );
  }
}
