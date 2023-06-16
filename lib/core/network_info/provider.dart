import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/core/network_info/network_info.dart';

part 'provider.g.dart';

@riverpod
NetworkInfo networkInfo(NetworkInfoRef ref) {
  return NetworkInfoImpl();
}
