import 'dart:convert';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';

abstract class LocalDataSource {
  Future<TodoList> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> updateTodo(Todo todo);

  Future<Todo> deleteTodo(String id);

  Future<void> todosToCache(TodoList todos);

  Future<int> getRevision();

  Future<void> clear();
}

// ignore: constant_identifier_names
const TODOS_LIST = 'todos_list';
// ignore: constant_identifier_names
const TODOS_LIST_REV = 'todos_list_revision';

class LocalDataSourceImpl implements LocalDataSource {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  Future<Todo> deleteTodo(String id) async {
    final TodoList todos = await getTodos();

    final todo = todos.getTodo(id);

    todosToCache(todos.deleteTodo(id));

    return todo[0];
  }

  @override
  Future<TodoList> getTodos() async {
    final sharedPreferences = await _sharedPreferences;
    var jsonTodoListString = sharedPreferences.getString(TODOS_LIST);

    try {
      final todoList = TodoList.fromJson(jsonDecode(jsonTodoListString!));
      return todoList;
    } on Exception {
      throw CacheException(message: 'Error getting data from cache');
    }
  }

  @override
  Future<void> saveTodo(Todo newTodo) async {
    final todos = await getTodos();

    todosToCache(todos.addTodo(newTodo));
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final todos = await getTodos();

    todosToCache(todos.updateTodo(todo));
  }

  @override
  Future<void> todosToCache(TodoList todos) async {
    final sharedPreferences = await _sharedPreferences;
    final jsonTodosListString = jsonEncode(todos.toJson()).toString();

    sharedPreferences.setString(TODOS_LIST, jsonTodosListString);
    sharedPreferences.setInt(TODOS_LIST_REV, todos.revision);
  }

  @override
  Future<int> getRevision() async {
    final sharedPreferences = await _sharedPreferences;
    final revision = sharedPreferences.getInt(TODOS_LIST_REV);

    return revision ?? -1;
  }

  @override
  Future<void> clear() async {
    final sharedPreferences = await _sharedPreferences;

    await sharedPreferences.clear();
  }
}
