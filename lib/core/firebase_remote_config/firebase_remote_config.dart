import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';

part 'firebase_remote_config.g.dart';

@riverpod
FirebaseRemoteConfigService firebaseRemoteConfigService(_) {
  throw UnimplementedError();
}

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService({
    required this.firebaseRemoteConfig,
  });

  final FirebaseRemoteConfig firebaseRemoteConfig;

  Future<void> init() async {
    try {
      _isError = false;
      await firebaseRemoteConfig.ensureInitialized();
      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await firebaseRemoteConfig.fetchAndActivate();
    } on FirebaseException catch (e) {
      _isError = true;
      logger.e('Unable to initialize Firebase Remote Config: $e');
    }
  }

  bool _isError = false;

  String? getImportanceColor() =>
      _isError ? null : firebaseRemoteConfig.getString('importanceColor');
}
