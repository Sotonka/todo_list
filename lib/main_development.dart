import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/app.dart';
import 'package:yandex_flutter_task/core/enums.dart';
import 'package:yandex_flutter_task/core/firebase_remote_config/firebase_remote_config.dart';
import 'package:yandex_flutter_task/core/firebase_services/firebase_services.dart';

void main() async {
  final firebaseServices = FirebaseServices();
  firebaseServices.init().then((_) {
    runApp(
      ProviderScope(
        overrides: [
          firebaseRemoteConfigServiceProvider.overrideWith(
            (_) => firebaseServices.firebaseRemoteConfigService,
          ),
        ],
        child: const App(
          flavour: Flavour.dev,
        ),
      ),
    );
  });
}
