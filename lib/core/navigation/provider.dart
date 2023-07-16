import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/navigation/delegate.dart';
import 'package:yandex_flutter_task/core/navigation/model.dart';
import 'package:yandex_flutter_task/core/navigation/navigator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

final todoRouterDelegateProvider = Provider<TodoRouterDelegate>(
  (ref) => TodoRouterDelegate(ref, [TodoListSegment()]),
);

final navigationStackProvider =
    StateProvider<TypedPath>((_) => [TodoListSegment()]);

@riverpod
AppNavigator appNavigator(AppNavigatorRef ref) {
  return AppNavigatorImpl(ref);
}
