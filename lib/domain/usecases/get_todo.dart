import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class GetTodoUseCase {
  Future<Either<Failure, Todo>> call(int id);
}

class GetTodoUseCaseImpl extends GetTodoUseCase {
  GetTodoUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Failure, Todo>> call(int id) async {
    return await todosRepository.getTodo(id);
  }
}
