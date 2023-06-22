import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class GetTodosUseCase {
  Future<Either<Exception, TodoList>> call();
}

class GetTodosUseCaseImpl extends GetTodosUseCase {
  GetTodosUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Exception, TodoList>> call() async {
    return await todosRepository.getTodos();
  }
}
