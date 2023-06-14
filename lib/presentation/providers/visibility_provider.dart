import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';

class VisibilityStateNotifier extends StateNotifier<bool> {
  VisibilityStateNotifier(this.ref) : super(false);

  final Ref ref;

  void toggle() {
    state = !state;

    ref.read(appLoggerProvider).i('PROVIDER: visibility toggled: $state');
  }
}

final visibilityStateNotifierProvider =
    StateNotifierProvider<VisibilityStateNotifier, bool>(
        (ref) => VisibilityStateNotifier(ref));
