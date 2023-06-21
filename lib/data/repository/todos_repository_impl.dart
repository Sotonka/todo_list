import 'dart:io';

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
    final hasNetwork = await networkChecker();

    if (hasNetwork) {
      try {
        var data = await remoteDataSource.getTodos();
        final localRev = await localDataSource.getRevision();

        // TODO
        // localDataSource.clear();

        if (data.revision > localRev) {
          localDataSource.todosToCache(data);
        } else if (data.revision < localRev) {
          final localData = await localDataSource.getTodos();

          data =
              await remoteDataSource.patchTodos(localData, localData.revision);
        }
        return Right(data);
      } on Exception catch (e) {
        return Left(
          ServerException(
            message: e.toString(),
          ),
        );
      }
    } else {
      try {
        final localData = await localDataSource.getTodos();

        return Right(localData);
      } on Exception catch (e) {
        return Left(
          CacheException(
            message: e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Exception, TodoList>> patchTodos(
      TodoList todos, int revision) async {
    try {
      return Right(
        await remoteDataSource.patchTodos(todos, revision),
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
  Future<Either<Exception, Todo>> createTodo(Todo todo, int revision) async {
    final hasNetwork = await networkChecker();

    if (hasNetwork) {
      try {
        final data = await remoteDataSource.createTodo(todo, revision);
        await localDataSource.saveTodo(todo);
        return Right(data);
      } on Exception catch (e) {
        return Left(
          ServerException(
            message: e.toString(),
          ),
        );
      }
    } else {
      try {
        await localDataSource.saveTodo(todo);

        return Right(todo);
      } on Exception catch (e) {
        return Left(
          CacheException(
            message: e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Exception, Todo>> updateTodo(Todo todo, int revision) async {
    final hasNetwork = await networkChecker();

    if (hasNetwork) {
      try {
        final data = await remoteDataSource.updateTodo(todo, revision);
        await localDataSource.updateTodo(todo);

        return Right(data);
      } on Exception catch (e) {
        return Left(
          ServerException(
            message: e.toString(),
          ),
        );
      }
    } else {
      try {
        await localDataSource.updateTodo(todo);

        return Right(todo);
      } on Exception catch (e) {
        return Left(
          CacheException(
            message: e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Exception, Todo>> deleteTodo(String id, int revision) async {
    final hasNetwork = await networkChecker();

    if (hasNetwork) {
      try {
        final data = await remoteDataSource.deleteTodo(id, revision);
        await localDataSource.deleteTodo(id);
        return Right(data);
      } on Exception catch (e) {
        return Left(
          ServerException(
            message: e.toString(),
          ),
        );
      }
    } else {
      try {
        final todo = await localDataSource.deleteTodo(id);

        return Right(todo);
      } on Exception catch (e) {
        return Left(
          CacheException(
            message: e.toString(),
          ),
        );
      }
    }
  }
}

Future<bool> networkChecker() async {
  try {
    final result = await InternetAddress.lookup('beta.mrdekk.ru');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
