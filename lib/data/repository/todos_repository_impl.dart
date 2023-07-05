import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/constants.dart';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';
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
    logger.v('START TodosRepositoryImpl: getTodos()');

    if (hasNetwork) {
      try {
        var data = await remoteDataSource.getTodos();
        final localRev = await localDataSource.getRevision();

        logger.i(
            'TodosRepositoryImpl: getTodos() current revision: local: $localRev remote: ${data.revision}');

        // TODO
        // localDataSource.clear();

        if (data.revision > localRev) {
          logger.i('TodosRepositoryImpl: getTodos() caching data to local');
          localDataSource.todosToCache(data);
        } else if (data.revision < localRev) {
          final localData = await localDataSource.getTodos();

          data =
              await remoteDataSource.patchTodos(localData, localData.revision);
          logger.i(
              'TodosRepositoryImpl: getTodos() data patched: local $localRev and remote ${data.revision}');
        }

        logger.v('END TodosRepositoryImpl: getTodos()');
        return Right(data);
      } on Exception catch (e) {
        logger.e(
            'TodosRepositoryImpl: getTodos() server exception ${e.toString()}');
        logger.v('END TodosRepositoryImpl: getTodos()');
        return Left(
          ServerException(
            message: e.toString(),
          ),
        );
      }
    } else {
      try {
        final localData = await localDataSource.getTodos();
        logger.i('TodosRepositoryImpl: getTodos(): local data recieved');
        logger.v('END TodosRepositoryImpl: getTodos()');

        return Right(localData);
      } on Exception catch (e) {
        logger.e(
            'TodosRepositoryImpl: getTodos() cache exception ${e.toString()}');
        logger.v('END TodosRepositoryImpl: getTodos()');
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
    logger.v(
        'START TodosRepositoryImpl: createTodo()\n${todo.id} rev. $revision');

    if (hasNetwork) {
      try {
        final data = await remoteDataSource.createTodo(todo, revision);
        logger.i(
            'TodosRepositoryImpl: createTodo() todo created @remote\n${todo.id} rev. $revision');
        await localDataSource.saveTodo(todo);
        logger.i(
            'TodosRepositoryImpl: createTodo() todo created @local\n${todo.id} rev. $revision');
        logger.v(
            'END TodosRepositoryImpl: createTodo()\n${todo.id} rev. $revision');
        return Right(data);
      } on Exception catch (e) {
        logger.e(
            'TodosRepositoryImpl: createTodo() server exception ${e.toString()}\n${todo.id} rev. $revision');
        logger.v(
            'END TodosRepositoryImpl: createTodo()\n${todo.id} rev. $revision');
        return Left(
          ServerException(
            message: e.toString(),
          ),
        );
      }
    } else {
      try {
        await localDataSource.saveTodo(todo);
        logger.i(
            'TodosRepositoryImpl: createTodo() todo created @local\n${todo.id} rev. $revision');
        logger.v(
            'END TodosRepositoryImpl: createTodo()\n${todo.id} rev. $revision');

        return Right(todo);
      } on Exception catch (e) {
        logger.e(
            'TodosRepositoryImpl: createTodo() cache exception ${e.toString()}\n${todo.id} rev. $revision');
        logger.v(
            'END TodosRepositoryImpl: createTodo()\n${todo.id} rev. $revision');
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
    logger.v(
        'START TodosRepositoryImpl: updateTodo()\n${todo.id} rev. $revision');

    if (hasNetwork) {
      try {
        final data = await remoteDataSource.updateTodo(todo, revision);
        logger.i(
            'TodosRepositoryImpl: updateTodo() todo updated @remote\n${todo.id} rev. $revision');
        await localDataSource.updateTodo(todo);

        logger.i(
            'TodosRepositoryImpl: updateTodo() todo updated @local\n${todo.id} rev. $revision');
        logger.v(
            'END TodosRepositoryImpl: updateTodo()\n${todo.id} rev. $revision');

        return Right(data);
      } on Exception catch (e) {
        logger.e(
            'TodosRepositoryImpl: updateTodo() server exception ${e.toString()}\n${todo.id} rev. $revision');
        logger.v(
            'END TodosRepositoryImpl: updateTodo()\n${todo.id} rev. $revision');
        return Left(
          ServerException(
            message: e.toString(),
          ),
        );
      }
    } else {
      try {
        await localDataSource.updateTodo(todo);
        logger.i(
            'TodosRepositoryImpl: updateTodo() todo updated @local\n${todo.id} rev. $revision');
        logger.v(
            'END TodosRepositoryImpl: updateTodo()\n${todo.id} rev. $revision');

        return Right(todo);
      } on Exception catch (e) {
        logger.e(
            'TodosRepositoryImpl: updateTodo() cache exception ${e.toString()}\n${todo.id} rev. $revision');
        logger.v(
            'END TodosRepositoryImpl: updateTodo()\n${todo.id} rev. $revision');
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
    logger.v('START TodosRepositoryImpl: deleteTodo()\n$id rev. $revision');

    if (hasNetwork) {
      try {
        final data = await remoteDataSource.deleteTodo(id, revision);
        logger.i(
            'TodosRepositoryImpl: deleteTodo() todo deleted @remote\n$id rev. $revision');
        await localDataSource.deleteTodo(id);
        logger.i(
            'TodosRepositoryImpl: deleteTodo() todo deleted @local\n$id rev. $revision');
        logger.v('END TodosRepositoryImpl: deleteTodo()\n$id rev. $revision');
        return Right(data);
      } on Exception catch (e) {
        logger.e(
            'TodosRepositoryImpl: deleteTodo() server exception ${e.toString()}\n$id rev. $revision');
        logger.v('END TodosRepositoryImpl: deleteTodo()\n$id rev. $revision');
        return Left(
          ServerException(
            message: e.toString(),
          ),
        );
      }
    } else {
      try {
        final todo = await localDataSource.deleteTodo(id);
        logger.i(
            'TodosRepositoryImpl: deleteTodo() todo deleted @local\n$id rev. $revision');
        logger.v('END TodosRepositoryImpl: deleteTodo()\n$id rev. $revision');

        return Right(todo);
      } on Exception catch (e) {
        logger.e(
            'TodosRepositoryImpl: deleteTodo() cache exception ${e.toString()}\n$id rev. $revision');
        logger.v('END TodosRepositoryImpl: deleteTodo()\n$id rev. $revision');
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
    final result = await InternetAddress.lookup(Api.host);
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    logger.w('networkChecker : no connection');
    return false;
  }
}
