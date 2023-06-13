import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/data/datasource/mock_datasource.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {
  final MockDataSource mockDataSource;

  TodosRepositoryImpl(this.mockDataSource);

  @override
  Future<Either<Failure, int>> deleteTodo(int id) async {
    try {
      final deletedId = await mockDataSource.deleteTodo(id);

      return Right(deletedId);
    } on DataException {
      return Left(DataFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodo(int id) async {
    try {
      final todo = await mockDataSource.getTodo(id);
      return Right(todo);
    } on Exception {
      return Left(DataFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await mockDataSource.getTodos();
      return Right(todos);
    } on Exception {
      return Left(DataFailure());
    }
  }

  @override
  Future<Either<Failure, int>> saveTodo(Todo todo) async {
    try {
      final createdId = await mockDataSource.saveTodo(todo);

      return Right(createdId);
    } on Exception {
      return Left(DataFailure());
    }
  }
}
