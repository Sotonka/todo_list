import 'package:yandex_flutter_task/domain/model/todo.dart';

abstract class MockDataSource {
  Future<List<Todo>> getTodos();

  Future<Todo> getTodo(int id);

  Future<int> saveTodo(Todo todo);

  Future<int> deleteTodo(int id);
}

class MockDataSourceImpl implements MockDataSource {
  final _source = {
    1: const Todo(
      id: 1,
      body: 'qwewqe1',
      completed: false,
      importance: 'none',
    ),
    2: const Todo(
      id: 2,
      body: '2',
      completed: false,
      importance: 'none',
    ),
    3: const Todo(
      id: 3,
      body: '3',
      completed: false,
      importance: 'none',
    ),
    4: const Todo(
      id: 4,
      body: '4',
      completed: false,
      importance: 'none',
    ),
    5: const Todo(
      id: 5,
      body: '',
      completed: false,
      importance: 'none',
    ),
    6: const Todo(
      id: 6,
      body: '',
      completed: false,
      importance: 'none',
    ),
    7: const Todo(
      id: 7,
      body: '',
      completed: false,
      importance: 'none',
    ),
    8: const Todo(
      id: 8,
      body: '',
      completed: false,
      importance: 'none',
    ),
    9: const Todo(
      id: 9,
      body: '',
      completed: false,
      importance: 'none',
    ),
    10: const Todo(
      id: 10,
      body: '',
      completed: false,
      importance: 'none',
    ),
  };

  // TODO
  /* if (response.statusCode == 200) {
      --request--
    } else {
      throw DataException();
    } */

  @override
  Future<int> deleteTodo(int id) async {
    _source.remove(id);
    return (id);
  }

  @override
  Future<Todo> getTodo(int id) async {
    return _source[id]!;
  }

  @override
  Future<List<Todo>> getTodos() async {
    final List<Todo> todoList = [];

    _source.forEach((key, value) {
      todoList.add(value);
    });

    return todoList;
  }

  @override
  Future<int> saveTodo(Todo todo) async {
    final ids = _source.keys.toList();
    ids.sort();
    final id = todo.id != null ? todo.id! : ids.last + 1;
    _source[id] = todo;

    return (id);
  }
}
