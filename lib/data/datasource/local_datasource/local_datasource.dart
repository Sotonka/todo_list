import 'dart:convert';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';

abstract class LocalDataSource {
  Future<TodoList> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(String id);

  Future<void> todosToCache(TodoList todos);
}

// ignore: constant_identifier_names
const TODOS_LIST = 'todos_list';
// ignore: constant_identifier_names
const TODOS_LIST_REV = 'todos_list_revision';

class LocalDataSourceImpl implements LocalDataSource {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  Future<void> deleteTodo(String id) async {
    final TodoList todos = await getTodos();

    todosToCache(todos.deleteTodo(id));
  }

  @override
  Future<TodoList> getTodos() async {
    final sharedPreferences = await _sharedPreferences;
    // TODO
    // await sharedPreferences.clear();
    var jsonTodoList = sharedPreferences.getStringList(TODOS_LIST);
    var revision = sharedPreferences.getInt(TODOS_LIST_REV);

    if (jsonTodoList == null) {
      sharedPreferences.setStringList(TODOS_LIST, []);
      sharedPreferences.setInt(TODOS_LIST_REV, 0);
      jsonTodoList = sharedPreferences.getStringList(TODOS_LIST);
      revision = sharedPreferences.getInt(TODOS_LIST_REV);
    }

    if (jsonTodoList != null) {
      final todoList =
          jsonTodoList.map((todo) => Todo.fromJson(json.decode(todo))).toList();

      return TodoList(
        revision: revision ?? 0,
        status: 'ok',
        list: todoList,
      );
    } else {
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

    final List<String> jsonTodosList =
        todos.list.map((todo) => json.encode(todos.toJson())).toList();

    sharedPreferences.setStringList(TODOS_LIST, jsonTodosList);
    sharedPreferences.setInt(TODOS_LIST_REV, todos.revision);
  }
}
