import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';
import 'package:yandex_flutter_task/domain/usecases/get_todos.dart';

import '../../mocks/repository.mocks.dart';

void main() {
  final TodosRepository repository = MockTodosRepository();
  final GetTodosUseCase usecase = GetTodosUseCaseImpl(repository);
  final date = DateTime.now().millisecondsSinceEpoch;
  final id = const Uuid().v4();
  final todo = Todo(
    id: id,
    text: 'test$id',
    done: false,
    deadline: null,
    created_at: date,
    last_updated_by: 'id$id',
    changed_at: date,
    importance: 'basic',
  );
  final todoList = TodoList(revision: 0, status: 'ok', list: [
    todo,
    todo,
    todo,
  ]);
  final expected = Right(todoList);

  setUp(() {
    when(repository.getTodos()).thenAnswer((_) async => Right(todoList));
  });

  test('should return todo list', () async {
    final actual = await usecase.call();
    expect(expected, actual);
    verify(repository.getTodos()).called(1);
  });
}
