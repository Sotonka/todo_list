import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/navigation/model.dart';
import 'package:yandex_flutter_task/core/navigation/provider.dart';
import 'package:yandex_flutter_task/presentation/screens/main_screen.dart';
import 'package:yandex_flutter_task/presentation/screens/todo_screen.dart';

class TodoRouterDelegate extends RouterDelegate<TypedPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<TypedPath> {
  TodoRouterDelegate(this.ref, this.homePath) {
    final unListen =
        ref.listen(navigationStackProvider, (_, __) => notifyListeners());
    ref.onDispose(unListen.close);
  }

  final Ref ref;
  final TypedPath homePath;

  @override
  Widget build(BuildContext context) {
    final navigationStack = currentConfiguration;
    if (navigationStack.isEmpty) return const SizedBox.shrink();

    Widget screenBuilder(TypedSegment segment) {
      if (segment is TodoListSegment) return const MainScreen();
      if (segment is CreateTodoSegment || segment is EditTodoSegment) {
        return const TodoScreen();
      }

      return const SizedBox.shrink();
    }

    return Navigator(
      key: navigatorKey,
      pages: navigationStack
          .map(
            (segment) => MaterialPage(
              key: ValueKey(segment.toString()),
              child: screenBuilder(segment),
            ),
          )
          .toList(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        final notifier = ref.read(navigationStackProvider.notifier);
        if (notifier.state.length <= 1) return false;
        notifier.state = [
          for (var i = 0; i < notifier.state.length - 1; i++) notifier.state[i]
        ];
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(TypedPath configuration) {
    if (configuration.isEmpty) configuration = homePath;
    navigate(configuration);
    return SynchronousFuture(null);
  }

  void navigate(TypedPath newPath) =>
      ref.read(navigationStackProvider.notifier).state = newPath;

  void pop([Object? result]) => navigatorKey.currentState?.pop(result);

  @override
  TypedPath get currentConfiguration => ref.read(navigationStackProvider);

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
