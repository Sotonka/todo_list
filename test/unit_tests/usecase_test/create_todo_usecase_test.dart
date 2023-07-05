import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';
import 'package:yandex_flutter_task/domain/usecases/create_todo.dart';

import '../../mocks/repository.mocks.dart';

void main() {
  final TodosRepository repository = MockTodosRepository();
  final CreateTodoUseCase usecase = CreateTodoUseCaseImpl(repository);
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
  final expected = Right(todo);
  const revision = 0;

  setUp(() {
    when(repository.createTodo(todo, revision))
        .thenAnswer((_) async => Right(todo));
  });

  test('should return created todo', () async {
    final actual = await usecase.call(todo, revision);
    expect(expected, actual);
    verify(repository.createTodo(todo, revision)).called(1);
  });
}
