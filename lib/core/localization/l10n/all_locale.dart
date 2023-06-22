import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllLocale {
  static const en = Locale('en', 'US');
  static const ru = Locale('ru', 'RU');
  static const ko = Locale('ko', 'KR');

  static const supportedLocales = [en, ru, ko];

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}
