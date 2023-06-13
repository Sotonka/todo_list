import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/data/datasource/mock_datasource/mock_datasource.dart';

part 'provider.g.dart';

@riverpod
MockDataSource mockDataSource(MockDataSourceRef ref) {
  return MockDataSourceImpl();
}
