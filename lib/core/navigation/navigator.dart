import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/navigation/model.dart';
import 'package:yandex_flutter_task/core/navigation/provider.dart';

abstract class AppNavigator {
  void goToList();
  void goToCreateTask();
  void goToEditTask(String id);
}

class AppNavigatorImpl implements AppNavigator {
  AppNavigatorImpl(this.ref);
  final Ref ref;

  @override
  void goToList() {
    ref.read(todoRouterDelegateProvider).navigate(
      [
        TodoListSegment(),
      ],
    );
  }

  @override
  void goToCreateTask() {
    ref.read(todoRouterDelegateProvider).navigate(
      [
        TodoListSegment(),
        CreateTodoSegment(),
      ],
    );
  }

  @override
  void goToEditTask(String id) {
    ref.read(todoRouterDelegateProvider).navigate(
      [
        TodoListSegment(),
        EditTodoSegment(id: id),
      ],
    );
  }
}
