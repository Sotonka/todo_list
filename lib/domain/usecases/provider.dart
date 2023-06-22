import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/data/repository/provider.dart';
import 'package:yandex_flutter_task/domain/usecases/delete_todo.dart';
import 'package:yandex_flutter_task/domain/usecases/get_todos.dart';
import 'package:yandex_flutter_task/domain/usecases/create_todo.dart';
import 'package:yandex_flutter_task/domain/usecases/patch_todos.dart';
import 'package:yandex_flutter_task/domain/usecases/update_todo.dart';

part 'provider.g.dart';

@riverpod
GetTodosUseCase getTodos(GetTodosRef ref) {
  return GetTodosUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
PatchTodosUseCase patchTodos(PatchTodosRef ref) {
  return PatchTodosUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
CreateTodoUseCase createTodo(CreateTodoRef ref) {
  return CreateTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
UpdateTodoUseCase updateTodo(UpdateTodoRef ref) {
  return UpdateTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}

@riverpod
DeleteTodoUseCase deleteTodo(DeleteTodoRef ref) {
  return DeleteTodoUseCaseImpl(ref.read(todosRepositoryProvider));
}
