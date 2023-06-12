import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/presentation/screens/main_screen.dart';
import 'package:yandex_flutter_task/presentation/screens/test_screen.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      theme: AppTheme.lightTheme.copyWith(
        extensions: [
          AppThemeColors.light,
        ],
      ),
      darkTheme: AppTheme.darkTheme.copyWith(
        extensions: [
          AppThemeColors.light,
        ],
      ),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}
