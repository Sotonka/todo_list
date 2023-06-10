import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/core/usecases/usecase.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

class GetTodosUseCaseImpl extends UseCase<List<Todo>, Params> {
  final TodosRepository todosRepository;

  GetTodosUseCaseImpl(this.todosRepository);

  @override
  Future<Either<Failure, List<Todo>>> call(Params params) async {
    return await todosRepository.getTodos();
  }
}

class Params extends Equatable {
  const Params();

  @override
  List<Object?> get props => [];
}
