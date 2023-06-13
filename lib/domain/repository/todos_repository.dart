import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';

abstract class TodosRepository {
  Future<Either<Failure, List<Todo>>> getTodos();

  Future<Either<Failure, Todo>> getTodo(int id);

  Future<Either<Failure, int>> saveTodo(Todo todo);

  Future<Either<Failure, int>> deleteTodo(int id);
}
