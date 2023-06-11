import 'package:flutter/material.dart';

class AppTextStyle {
  static const String _defaultFontFamily = 'Roboto';

  static const TextStyle largeTitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: _defaultFontFamily,
    fontSize: 32,
    height: 32 / 38,
  );

  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: _defaultFontFamily,
    fontSize: 20,
    height: 20 / 32,
  );
  static const TextStyle button = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: _defaultFontFamily,
    fontSize: 14,
    height: 14 / 24,
  );
  static const TextStyle body = TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: _defaultFontFamily,
    fontSize: 16,
    height: 16 / 20,
  );
  static const TextStyle subhead = TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: _defaultFontFamily,
    fontSize: 14,
    height: 14 / 20,
  );

  const AppTextStyle._();
}
