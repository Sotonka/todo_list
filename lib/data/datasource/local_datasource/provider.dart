import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/data/datasource/local_datasource/local_datasource.dart';

part 'provider.g.dart';

@riverpod
LocalDataSource localDataSource(LocalDataSourceRef ref) {
  return LocalDataSourceImpl();
}
