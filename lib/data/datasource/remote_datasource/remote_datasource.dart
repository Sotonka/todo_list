// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:yandex_flutter_task/core/constants.dart';
import 'package:yandex_flutter_task/core/env/env.dart';
import 'dart:io';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
//import 'package:yandex_flutter_task/core/env/env.dart';

BaseOptions baseOptions = BaseOptions(
  baseUrl: Env.baseUrl,
  receiveDataWhenStatusError: true,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
  sendTimeout: const Duration(seconds: 5),
  // ignore: avoid_redundant_argument_values
  responseType: ResponseType.json,
  headers: {
    Api.headerAuth: "Bearer ${Env.token}",
  },
);

abstract class RemoteDataSource {
  Future<TodoList> getTodos();

  Future<TodoList> patchTodos(TodoList todos, int revision);

  Future<Todo> createTodo(Todo? todo, int revision);

  Future<Todo> updateTodo(Todo todo, int revision);

  Future<Todo> deleteTodo(String id, int revision);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final _dio = Dio(baseOptions);

  @override
  Future<TodoList> getTodos() async {
    _init(_dio);

    try {
      final response = await _dio.get<String>('/list');
      final dynamic todoListJson = jsonDecode(response.data ?? '');

      return TodoList.fromJson(todoListJson);
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<TodoList> patchTodos(TodoList todos, int revision) async {
    _init(_dio);
    try {
      _dio.options.headers[Api.headerRevision] = '$revision';
      final response = await _dio.patch<String>(
        '/list',
        data: todos.toJson(),
      );

      final dynamic todoListJson = jsonDecode(response.data ?? '');

      return TodoList.fromJson(todoListJson);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message.toString(),
      );
    }
  }

  @override
  Future<Todo> createTodo(Todo? todo, int revision) async {
    _init(_dio);

    try {
      _dio.options.headers[Api.headerRevision] = '$revision';
      final response = await _dio.post<String>(
        '/list',
        data: {
          "status": "ok",
          "element": todo!.toJson(),
        },
      );

      final dynamic todoJson = jsonDecode(response.data ?? '');

      return Todo.fromJson(todoJson['element']);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message.toString(),
      );
    }
  }

  @override
  Future<Todo> updateTodo(Todo todo, int revision) async {
    _init(_dio);
    try {
      _dio.options.headers[Api.headerRevision] = '$revision';

      final response = await _dio.put<String>(
        '/list/${todo.id}',
        data: {
          "status": "ok",
          "element": todo.toJson(),
        },
      );

      final dynamic todoJson = jsonDecode(response.data ?? '');

      return Todo.fromJson(todoJson['element']);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message.toString(),
      );
    }
  }

  @override
  Future<Todo> deleteTodo(String id, int revision) async {
    _init(_dio);

    try {
      _dio.options.headers[Api.headerRevision] = '$revision';
      final response = await _dio.delete<String>(
        '/list/$id',
      );

      final dynamic todoJson = jsonDecode(response.data ?? '');

      return Todo.fromJson(todoJson['element']);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message.toString(),
      );
    }
  }
}

_init(Dio dio) {
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
}
