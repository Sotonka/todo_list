import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/core/firebase_remote_config/firebase_remote_config.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';
import 'package:yandex_flutter_task/firebase_options.dart';

class FirebaseServices {
  late final FirebaseRemoteConfigService _firebaseRemoteConfigService;

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    logger.d('Firebase initialization started');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    logger.d('Firebase initialized');
    logger.d('FirebaseRemoteConfigService initialization started');
    _firebaseRemoteConfigService = FirebaseRemoteConfigService(
      firebaseRemoteConfig: FirebaseRemoteConfig.instance,
    );

    await _firebaseRemoteConfigService.init();
    logger.d('FirebaseRemoteConfigService initialized');
    _initCrashlytics();
  }

  FirebaseRemoteConfigService get firebaseRemoteConfigService =>
      _firebaseRemoteConfigService;
}

void _initCrashlytics() {
  FlutterError.onError = (errorDetails) {
    logger.e('Caught error in FlutterError.onError');
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.e('Caught error in PlatformDispatcher.onError');
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );

    return true;
  };
  logger.d('Crashlytics initialized');
}
