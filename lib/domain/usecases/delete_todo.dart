import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class DeleteTodoUseCase {
  Future<Either<Exception, dynamic>> call(String id, int revision);
}

class DeleteTodoUseCaseImpl extends DeleteTodoUseCase {
  DeleteTodoUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Exception, dynamic>> call(String id, int revision) async {
    return todosRepository.deleteTodo(id, revision);
  }
}
