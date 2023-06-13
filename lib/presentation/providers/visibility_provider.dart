import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisibilityStateNotifier extends StateNotifier<bool> {
  VisibilityStateNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final visibilityStateNotifierProvider =
    StateNotifierProvider<VisibilityStateNotifier, bool>(
        (ref) => VisibilityStateNotifier());
