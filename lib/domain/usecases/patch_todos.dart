import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class PatchTodosUseCase {
  Future<Either<Exception, TodoList>> call(TodoList todos, int revision);
}

class PatchTodosUseCaseImpl extends PatchTodosUseCase {
  PatchTodosUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Exception, TodoList>> call(TodoList todos, int revision) async {
    return await todosRepository.patchTodos(todos, revision);
  }
}
