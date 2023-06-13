import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/data/datasource/local_datasource/provider.dart';
import 'package:yandex_flutter_task/data/repository/todos_repository_impl.dart';
import 'package:yandex_flutter_task/domain/repository/todos_repository.dart';

part 'provider.g.dart';

@riverpod
TodosRepository todosRepository(TodosRepositoryRef ref) {
  return TodosRepositoryImpl(ref.read(localDataSourceProvider));
}
