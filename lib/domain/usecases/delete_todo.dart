import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

abstract class DeleteTodoUseCase {
  Future<Either<Failure, dynamic>> call(int id);
}

class DeleteTodoUseCaseImpl extends DeleteTodoUseCase {
  DeleteTodoUseCaseImpl(this.todosRepository);
  final TodosRepository todosRepository;

  @override
  Future<Either<Failure, dynamic>> call(int id) async {
    return todosRepository.deleteTodo(id);
  }
}
