import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/data/datasource/local_datasource/local_datasource.dart';
import 'package:yandex_flutter_task/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  TodosRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, int>> deleteTodo(int id) async {
    try {
      final deletedId = await localDataSource.deleteTodo(id);

      return Right(deletedId);
    } on DataException {
      return Left(DataFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodo(int id) async {
    try {
      final todo = await localDataSource.getTodo(id);
      return Right(todo);
    } on Exception {
      return Left(DataFailure());
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      //final todos = await localDataSource.getTodos();
      final todos = await remoteDataSource.getTodos();
      return Right(todos);
    } on Exception {
      return Left(DataFailure());
    }
  }

  @override
  Future<Either<Failure, int>> saveTodo(Todo todo) async {
    try {
      final createdId = await localDataSource.saveTodo(todo);

      return Right(createdId);
    } on Exception {
      return Left(DataFailure());
    }
  }
}
