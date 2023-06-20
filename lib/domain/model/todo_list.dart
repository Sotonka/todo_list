// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';

part 'todo_list.freezed.dart';
part 'todo_list.g.dart';

@freezed
class TodoList with _$TodoList {
  const factory TodoList({
    required int revision,
    required String status,
    required List<Todo> list,
  }) = _TodoList;

  factory TodoList.fromJson(Map<String, dynamic> json) =>
      _$TodoListFromJson(json);

  const TodoList._();

  operator [](int index) => list[index];

  int get length => list.length;

  int get completedTodoCount => list.where((todo) => todo.done).length;

  TodoList addTodo(Todo todo) =>
      copyWith(revision: revision + 1, list: [...list, todo]);

  TodoList updateTodo(Todo newTodo) => copyWith(
      revision: revision + 1,
      list:
          list.map((todo) => newTodo.id == todo.id ? newTodo : todo).toList());

  TodoList deleteTodo(String id) => copyWith(
      revision: revision + 1,
      list: list.where((todo) => todo.id != id).toList());

  TodoList getTodo(String id) =>
      copyWith(list: list.where((todo) => todo.id == id).toList());

  TodoList filterByCompleted() =>
      copyWith(list: list.where((todo) => todo.done).toList());
  TodoList filterByIncompleted() =>
      copyWith(list: list.where((todo) => !todo.done).toList());
}
