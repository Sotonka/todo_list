import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';
import 'package:yandex_flutter_task/core/usecases/usecase.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

class DeleteTodoUseCaseImpl extends UseCase<void, Params> {
  final TodosRepository todosRepository;

  DeleteTodoUseCaseImpl(this.todosRepository);

  @override
  Future<Either<Failure, dynamic>> call(params) async {
    await todosRepository.deleteTodo(params.id);
    return const Right(null);
  }
}

class Params extends Equatable {
  final int id;
  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
