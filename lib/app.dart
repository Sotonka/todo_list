import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:yandex_flutter_task/app_router.dart';
import 'package:yandex_flutter_task/presentation/screens/main_screen.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
          // ignore: deprecated_member_use
          SchedulerBinding.instance.window.platformBrightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}
