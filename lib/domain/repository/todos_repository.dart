import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';

abstract class TodosRepository {
  Future<Either<Exception, TodoList>> getTodos();

  Future<Either<Exception, TodoList>> patchTodos(TodoList todos, int revision);

  Future<Either<Exception, Todo>> createTodo(Todo todo, int revision);

  Future<Either<Exception, Todo>> updateTodo(Todo todo, int revision);

  Future<Either<Exception, Todo>> deleteTodo(String id, int revision);
}
