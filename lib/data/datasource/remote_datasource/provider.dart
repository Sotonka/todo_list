import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/data/datasource/remote_datasource/remote_datasource.dart';

part 'provider.g.dart';

@riverpod
RemoteDataSource remoteDataSource(RemoteDataSourceRef ref) {
  return RemoteDataSourceImpl();
}
