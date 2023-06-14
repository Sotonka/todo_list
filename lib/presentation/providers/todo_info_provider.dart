import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';

class TodoInfoNotifier extends StateNotifier<Todo> {
  TodoInfoNotifier() : super(const Todo(body: ''));

  void initTodo(Todo initial) {
    state = initial;
  }

  void updateBody(String body) {
    state = state.copyWith(body: body);
  }

  void updateDeadline(DateTime? deadline) {
    state = state.copyWith(deadline: deadline);
  }

  void updateImportance(String importance) {
    switch (importance.toLowerCase()) {
      case 'нет':
        state = state.copyWith(importance: 'no');

      case 'низкий':
        state = state.copyWith(importance: 'low');

      case 'высокий':
        state = state.copyWith(importance: 'high');

      default:
        state = state.copyWith(importance: 'no');
    }
  }
}

final todoInfoNotifierProvider =
    StateNotifierProvider<TodoInfoNotifier, Todo>((ref) => TodoInfoNotifier());
