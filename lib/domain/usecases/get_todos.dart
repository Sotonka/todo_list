import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class GetTodosUseCase {
  Future<Either<Failure, List<Todo>>> call();
}

class GetTodosUseCaseImpl extends GetTodosUseCase {
  GetTodosUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Failure, List<Todo>>> call() async {
    return await todosRepository.getTodos();
  }
}
