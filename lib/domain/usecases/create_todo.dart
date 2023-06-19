import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class CreateTodoUseCase {
  Future<Either<Exception, Todo>> call(Todo todo, int revision);
}

class CreateTodoUseCaseImpl extends CreateTodoUseCase {
  CreateTodoUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Exception, Todo>> call(Todo todo, int revision) async {
    return todosRepository.createTodo(todo, revision);
  }
}
