import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:yandex_flutter_task/app_router.dart';
import 'package:yandex_flutter_task/core/localization/l10n/all_locale.dart';
import 'package:yandex_flutter_task/presentation/screens/main_screen.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AllLocale.supportedLocales,
      locale: const Locale('ru', 'RU'),
      initialRoute: AppRouter.root,
      onGenerateRoute: AppRouter.generateRoute,
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
      home: const MainScreen(),
    );
  }
}
