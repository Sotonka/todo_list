/* import 'package:mockito/mockito.dart';
import 'package:yandex_flutter_task/data/datasource/local_datasource/local_datasource.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';

class MockLocalRepository extends Mock implements LocalDataSource {
  TodoList todos = const TodoList(
    revision: 0,
    status: 'ok',
    list: [],
  );

  int revision = 0;

  @override
  Future<TodoList> getTodos() async {
    await todos.
  }
}
 */