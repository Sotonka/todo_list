import 'package:yandex_flutter_task/domain/model/todo.dart';

abstract class MockDataSource {
  Future<List<Todo>> getTodos();

  Future<Todo> getTodo(int id);

  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(int id);
}

class MockDataSourceImpl implements MockDataSource {
  final _source = {};

  @override
  Future<void> deleteTodo(int id) async {
    _source.remove(id);
  }

  @override
  Future<Todo> getTodo(int id) async {
    return _source[id];
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
  Future<void> saveTodo(Todo todo) async {
    if (todo.id != null) {
      _source[todo.id] = todo;
    } else {
      // TODO если id не указано - генерировать
    }
  }
}
