import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class SaveTodoUseCase {
  Future<Either<Failure, int>> call(Todo todo);
}

class SaveTodoUseCaseImpl extends SaveTodoUseCase {
  SaveTodoUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Failure, int>> call(Todo todo) async {
    return todosRepository.saveTodo(todo);
  }
}
