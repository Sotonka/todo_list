import 'dart:convert';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';

const _url = 'https://beta.mrdekk.ru/todobackend';
const _token = 'chlorophyllase';

BaseOptions baseOptions = BaseOptions(
  baseUrl: _url,
  receiveDataWhenStatusError: true,
  /* connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
  sendTimeout: const Duration(seconds: 5), */
  // ignore: avoid_redundant_argument_values
  responseType: ResponseType.json,
  headers: {
    "Authorization": "Bearer $_token",
  },
);

abstract class RemoteDataSource {
  Future<List<Todo>> getTodos();

  Future<Todo> getTodo(int id);

  Future<int> saveTodo(Todo todo);

  Future<int> deleteTodo(int id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final _dio = Dio(baseOptions);

  @override
  Future<int> deleteTodo(int id) async {
    _initInterceptors(_dio);
    /* try {
      final response = await _dio.get<String>('/place/$id');

      final dynamic placeJson = jsonDecode(response.data ?? '');

      return Place.fromJson(placeJson as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException(
        message: e.message,
      );
    } */
    throw UnimplementedError();
  }

  @override
  Future<Todo> getTodo(int id) async {
    _initInterceptors(_dio);
    _dio.options.headers['X'] = 'XX';
    try {
      final response = await _dio.get<String>('/list/$id');

      final dynamic todoJson = jsonDecode(response.data ?? '');

      throw UnimplementedError();

      //return Todo.fromJson(todoJson['element']);
    } on DioError catch (e) {
      throw ServerException(
        message: e.message ?? 'unknown exception',
      );
    }
  }

  @override
  Future<List<Todo>> getTodos() async {
    _initInterceptors(_dio);
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    try {
      final response = await _dio.get<String>('/list');
      print('SUCCESS');

      final dynamic todoJson = jsonDecode(response.data ?? '');
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      print('todoJson');

      throw UnimplementedError();

      //return Todo.fromJson(todoJson['element']);
    } on DioError catch (e) {
      print('error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      print(e.message);

      throw ServerException(
        message: e.message ?? 'unknown exception',
      );
    }
  }

  @override
  Future<int> saveTodo(Todo todo) async {
    _initInterceptors(_dio);
    // TODO: implement saveTodo
    throw UnimplementedError();
  }
}

void _initInterceptors(Dio dio) {
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (e, handler) {
        return handler.next(e);
      },
      onRequest: (options, handler) {
        // ignore: avoid_print
        print('Запрос отправляется');

        return handler.next(options);
      },
      onResponse: (e, handler) {
        // ignore: avoid_print
        print('Ответ получен');

        return handler.next(e);
      },
    ),
  );
}
