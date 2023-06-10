import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/presentation/screens/main_screen.dart';
import 'package:yandex_flutter_task/presentation/screens/todo_screen.dart';

abstract class AppRouter {
  static const String root = '/';
  static const String mainScreen = '/mainScreen';
  static const String todoScreen = '/todoScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.mainScreen:
        return MaterialPageRoute<Object?>(
          builder: (_) => const MainScreen(),
        );

      case AppRouter.todoScreen:
        return MaterialPageRoute<Object?>(
          builder: (_) => const TodoScreen(),
        );

      case AppRouter.root:
        return MaterialPageRoute<Object?>(
          builder: (_) => const MainScreen(),
        );

      default:
        return MaterialPageRoute<Object?>(
          builder: (_) => const MainScreen(),
        );
    }
  }
}
