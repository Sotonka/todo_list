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
    state = state.copyWith(importance: importance);
  }
}

final todoInfoNotifierProvider =
    StateNotifierProvider<TodoInfoNotifier, Todo>((ref) => TodoInfoNotifier());
