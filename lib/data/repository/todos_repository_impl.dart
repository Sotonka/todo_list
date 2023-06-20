import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/data/datasource/local_datasource/local_datasource.dart';
import 'package:yandex_flutter_task/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  TodosRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Exception, TodoList>> getTodos() async {
    try {
      return Right(
        await remoteDataSource.getTodos(),
      );
    } on Exception {
      return Left(ServerException(message: 'ServerException'));
    }
  }

  @override
  Future<Either<Exception, TodoList>> patchTodos(
      TodoList todos, int revision) async {
    try {
      return Right(
        await remoteDataSource.getTodos(),
      );
    } on Exception {
      return Left(ServerException(message: 'ServerException'));
    }
  }

  @override
  Future<Either<Exception, Todo>> createTodo(Todo todo, int revision) async {
    try {
      return Right(
        await remoteDataSource.createTodo(todo, revision),
      );
    } on Exception catch (e) {
      return Left(
        ServerException(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Exception, Todo>> updateTodo(Todo todo, int revision) async {
    try {
      return Right(
        await remoteDataSource.updateTodo(todo, revision),
      );
    } on Exception {
      return Left(ServerException(message: 'ServerException'));
    }
  }

  @override
  Future<Either<Exception, Todo>> deleteTodo(String id, int revision) async {
    try {
      return Right(
        await remoteDataSource.deleteTodo(id, revision),
      );
    } on ServerException {
      return Left(ServerException(message: 'ServerException'));
    }
  }
}
