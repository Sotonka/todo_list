import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/app.dart';
import 'package:yandex_flutter_task/core/firebase_remote_config/firebase_remote_config.dart';

import 'firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final firebaseRemoteConfigService = FirebaseRemoteConfigService(
      firebaseRemoteConfig: FirebaseRemoteConfig.instance,
    );
    await firebaseRemoteConfigService.init();
    _initCrashlytics();
    runApp(
      ProviderScope(
        overrides: [
          firebaseRemoteConfigServiceProvider.overrideWith(
            (_) => firebaseRemoteConfigService,
          ),
        ],
        child: const App(),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

void _initCrashlytics() {
  FlutterError.onError = (errorDetails) {
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    return true;
  };
}
