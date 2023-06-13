import 'dart:convert';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<Todo>> getTodos();

  Future<Todo> getTodo(int id);

  Future<int> saveTodo(Todo todo);

  Future<int> deleteTodo(int id);

  Future<List<String>> todosToCache(List<Todo> todos);
}

// ignore: constant_identifier_names
const TODOS_LIST = 'todos_list';

class LocalDataSourceImpl implements LocalDataSource {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  Future<int> deleteTodo(int id) async {
    final todos = await getTodos();

    todos.removeWhere((element) => element.id == id);
    todosToCache(todos);
    // TODO
    print('ELEMENT WITH ID $id HAS BEEN DELETED');
    return (id);
  }

  @override
  Future<Todo> getTodo(int id) async {
    final sharedPreferences = await _sharedPreferences;
    final jsonTodoList = sharedPreferences.getStringList(TODOS_LIST);

    if (jsonTodoList != null) {
      return Future.value(jsonTodoList
          .map((todo) => Todo.fromJson(json.decode(todo)))
          .toList()[id]);
    } else {
      throw DataException();
    }
  }

  @override
  Future<List<Todo>> getTodos() async {
    final sharedPreferences = await _sharedPreferences;
    // await sharedPreferences.clear();
    var jsonTodoList = sharedPreferences.getStringList(TODOS_LIST);

    if (jsonTodoList == null) {
      sharedPreferences.setStringList(TODOS_LIST, []);
    }

    if (jsonTodoList != null) {
      return Future.value(jsonTodoList
          .map((todo) => Todo.fromJson(json.decode(todo)))
          .toList());
    } else {
      throw DataException();
    }
  }

  @override
  Future<int> saveTodo(Todo todo) async {
    final todos = await getTodos();
    final ids = [];
    var id = 0;
    if (todos.isNotEmpty) {
      for (var todo in todos) {
        ids.add(todo.id);
      }
      ids.sort();
      id = ids.last + 1;
    }

    id = todo.id ?? id;

    todos.add(
      todo.copyWith(id: id),
    );
    todosToCache(todos);
    // TODO
    print('ELEMENT WITH ID $id HAS BEEN ADDED');

    return (id);
  }

  @override
  Future<List<String>> todosToCache(List<Todo> todos) async {
    final sharedPreferences = await _sharedPreferences;

    final List<String> jsonTodosList =
        todos.map((todo) => json.encode(todo.toJson())).toList();

    sharedPreferences.setStringList(TODOS_LIST, jsonTodosList);

    return Future.value(jsonTodosList);
  }
}
