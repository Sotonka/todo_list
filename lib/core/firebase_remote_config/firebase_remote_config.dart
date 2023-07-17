import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';

part 'firebase_remote_config.g.dart';

@riverpod
FirebaseRemoteConfigService firebaseRemoteConfigService(
    FirebaseRemoteConfigServiceRef ref) {
  return FirebaseRemoteConfigService(
      firebaseRemoteConfig: FirebaseRemoteConfig.instance);
}

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService({
    required this.firebaseRemoteConfig,
  });

  final FirebaseRemoteConfig firebaseRemoteConfig;

  late ValueNotifier<String?> colorNotifier = ValueNotifier(getImportanceColor);

  Future<void> init() async {
    try {
      _isError = false;
      await firebaseRemoteConfig.ensureInitialized();

      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 60),
        ),
      );
      await firebaseRemoteConfig.fetchAndActivate();
      firebaseRemoteConfig.onConfigUpdated.listen((event) async {
        await firebaseRemoteConfig.activate();

        colorNotifier.value = getImportanceColor;
        logger.d(
            'FirebaseRemoteConfigService VALUE UPDATED ${colorNotifier.value}');
      });
    } on FirebaseException catch (e) {
      _isError = true;
      logger.e('Unable to initialize Firebase Remote Config: $e');
    }
  }

  bool _isError = false;

  String? get getImportanceColor =>
      _isError ? null : firebaseRemoteConfig.getString('importanceColor');
}
