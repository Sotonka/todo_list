import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class UpdateTodoUseCase {
  Future<Either<Exception, Todo>> call(Todo todo, int revision);
}

class UpdateTodoUseCaseImpl extends UpdateTodoUseCase {
  UpdateTodoUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Exception, Todo>> call(Todo todo, int revision) async {
    return todosRepository.updateTodo(todo, revision);
  }
}
