import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/data/repository/provider.dart';
import 'package:yandex_flutter_task/domain/usecases/delete_todo.dart';
import 'package:yandex_flutter_task/domain/usecases/get_todo.dart';
import 'package:yandex_flutter_task/domain/usecases/get_todos.dart';
import 'package:yandex_flutter_task/domain/usecases/save_todo.dart';

part 'provider.g.dart';

@riverpod
GetTodosUseCase getTodos(GetTodosRef ref) {
  return GetTodosUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
GetTodoUseCase getTodo(GetTodoRef ref) {
  return GetTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
SaveTodoUseCase saveTodo(SaveTodoRef ref) {
  return SaveTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
DeleteTodoUseCase deleteTodo(DeleteTodoRef ref) {
  return DeleteTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}
