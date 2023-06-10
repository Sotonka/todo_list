import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/core/usecases/usecase.dart';
import 'package:yandex_flutter_task/data/repository/provider.dart';
import 'package:yandex_flutter_task/domain/usecases/delete_todo.dart';
import 'package:yandex_flutter_task/domain/usecases/get_todo.dart';
import 'package:yandex_flutter_task/domain/usecases/get_todos.dart';
import 'package:yandex_flutter_task/domain/usecases/save_todo.dart';

part 'provider.g.dart';

@riverpod
UseCase getTodos(GetTodosRef ref) {
  return GetTodosUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
UseCase getTodo(GetTodoRef ref) {
  return GetTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
UseCase saveTodo(SaveTodoRef ref) {
  return SaveTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
UseCase deleteTodo(DeleteTodoRef ref) {
  return DeleteTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}
