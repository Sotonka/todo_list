import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/enums.dart';
import 'package:yandex_flutter_task/core/localization/l10n/all_locale.dart';
import 'package:yandex_flutter_task/core/navigation/parser.dart';
import 'package:yandex_flutter_task/core/navigation/provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends ConsumerWidget {
  const App({
    super.key,
    required this.flavour,
  });
  final Flavour flavour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );

    return MaterialApp.router(
      routerDelegate: ref.read(todoRouterDelegateProvider),
      routeInformationParser: RouteInformationParserImpl(),
      debugShowCheckedModeBanner: flavour == Flavour.dev ? true : false,
      title: 'Todos',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AllLocale.supportedLocales,
      locale: const Locale('ru', 'RU'),
      theme: AppTheme.lightTheme.copyWith(
        extensions: [
          AppThemeColors.light,
        ],
      ),
      darkTheme: AppTheme.darkTheme.copyWith(
        extensions: [
          AppThemeColors.dark,
        ],
      ),
      themeMode: ThemeMode.system,
    );
  }
}
