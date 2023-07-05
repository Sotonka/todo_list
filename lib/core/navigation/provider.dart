import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/navigation/delegate.dart';
import 'package:yandex_flutter_task/core/navigation/model.dart';

final routerDelegateProvider = Provider<TodoRouterDelegate>(
  (ref) => TodoRouterDelegate(ref, [TodoListSegment()]),
);

final navigationStackProvider =
    StateProvider<TypedPath>((_) => [TodoListSegment()]);
