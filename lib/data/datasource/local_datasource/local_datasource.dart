import 'dart:convert';
import 'package:yandex_flutter_task/core/error/exception.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<Todo>> getTodos();

  Future<Todo> getTodo(int id);

  Future<int> saveTodo(Todo todo);

  Future<int> deleteTodo(int id);

  Future<List<String>> todosToCache(List<Todo> todos);
  Future<void> fillWithMocks();
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
    // TODO
    // await sharedPreferences.clear();
    var jsonTodoList = sharedPreferences.getStringList(TODOS_LIST);

    if (jsonTodoList == null) {
      sharedPreferences.setStringList(TODOS_LIST, []);
      jsonTodoList = sharedPreferences.getStringList(TODOS_LIST);
    }

    if (jsonTodoList != null) {
      final todoList =
          jsonTodoList.map((todo) => Todo.fromJson(json.decode(todo))).toList();
      // TODO
      // right now sort only by id ascending
      todoList.sort((a, b) => a.id!.compareTo(b.id!));
      return Future.value(todoList);
    } else {
      throw DataException();
    }
  }

  @override
  Future<int> saveTodo(Todo todo) async {
    final todos = await getTodos();
    if (todo.id == null) {
      final ids = [];
      var id = 0;
      if (todos.isNotEmpty) {
        for (var todo in todos) {
          ids.add(todo.id);
        }
        ids.sort();
        id = ids.last + 1;
      }
      todos.add(
        todo.copyWith(id: id),
      );
      // TODO
      print('ELEMENT WITH ID $id HAS BEEN ADDED');
      todosToCache(todos);
      return (id);
    } else {
      todos.removeWhere((element) => element.id == todo.id);
      todos.add(todo);
      // TODO
      print('ELEMENT WITH ID ${todo.id!} HAS BEEN CHANGED');
      todosToCache(todos);
      return (todo.id!);
    }
  }

  @override
  Future<List<String>> todosToCache(List<Todo> todos) async {
    final sharedPreferences = await _sharedPreferences;

    final List<String> jsonTodosList =
        todos.map((todo) => json.encode(todo.toJson())).toList();

    sharedPreferences.setStringList(TODOS_LIST, jsonTodosList);

    return Future.value(jsonTodosList);
  }

  @override
  Future<void> fillWithMocks() async {
    final List<Todo> list = [
      Todo(
        id: 1,
        body: 'Cъешь',
        completed: false,
        deadline: DateTime.now(),
        importance: 'no',
      ),
      Todo(
        id: 2,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        deadline: DateTime.now(),
        importance: 'no',
      ),
      Todo(
        id: 3,
        body:
            'Cъешь ещё этих мягких французских булок, да выпей чаю Cъешь ещё этих мягких французских булок, да выпей чаю Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        deadline: DateTime.now(),
        importance: 'no',
      ),
      const Todo(
        id: 4,
        body: 'Cъешь ещё этих мягких французских булок',
        completed: true,
        importance: 'no',
      ),
      Todo(
        id: 5,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        deadline: DateTime.now(),
        importance: 'high',
      ),
      Todo(
        id: 6,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        deadline: DateTime.now(),
        importance: 'low',
      ),
      const Todo(
        id: 7,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        importance: 'no',
      ),
      const Todo(
        id: 8,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: true,
        importance: 'no',
      ),
      const Todo(
        id: 9,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        importance: 'no',
      ),
      const Todo(
        id: 10,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: true,
        importance: 'no',
      ),
      const Todo(
        id: 11,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        importance: 'no',
      ),
      const Todo(
        id: 12,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: true,
        importance: 'no',
      ),
      const Todo(
        id: 13,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        importance: 'no',
      ),
      const Todo(
        id: 14,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: true,
        importance: 'no',
      ),
      const Todo(
        id: 15,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: false,
        importance: 'no',
      ),
      const Todo(
        id: 16,
        body: 'Cъешь ещё этих мягких французских булок, да выпей чаю',
        completed: true,
        importance: 'no',
      ),
    ];

    todosToCache(list);
  }
}
