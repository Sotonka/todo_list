import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/core/firebase_services/firebase_services.dart';

part 'provider.g.dart';

@riverpod
FirebaseServices firebaseServices(FirebaseServicesRef ref) {
  return FirebaseServices();
}
