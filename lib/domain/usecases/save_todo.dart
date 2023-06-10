import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/core/usecases/usecase.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

class SaveTodoUseCaseImpl extends UseCase<void, SaveTodoParams> {
  final TodosRepository todosRepository;

  SaveTodoUseCaseImpl(this.todosRepository);

  @override
  Future<Either<Failure, dynamic>> call(params) async {
    await todosRepository.saveTodo(params.todo);
    return const Right(null);
  }
}

class SaveTodoParams extends Equatable {
  final Todo todo;
  const SaveTodoParams({required this.todo});

  @override
  List<Object?> get props => [todo];
}
