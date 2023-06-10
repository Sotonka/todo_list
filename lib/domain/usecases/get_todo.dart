import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/core/usecases/usecase.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

class GetTodoUseCaseImpl extends UseCase<Todo, Params> {
  final TodosRepository todosRepository;

  GetTodoUseCaseImpl(this.todosRepository);

  @override
  Future<Either<Failure, Todo>> call(Params params) async {
    return await todosRepository.getTodo(params.id);
  }
}

class Params extends Equatable {
  final int id;
  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
