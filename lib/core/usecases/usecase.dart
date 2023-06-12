import 'package:dartz/dartz.dart';
import 'package:yandex_flutter_task/core/error/failure.dart';

abstract class UseCaseWithParams<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}
