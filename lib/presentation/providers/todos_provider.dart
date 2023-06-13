import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/data/datasource/local_datasource/provider.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/usecases/provider.dart';

class TodosStateNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  TodosStateNotifier(this.ref) : super(const AsyncLoading()) {
    loadTodos();
  }

  final Ref ref;
  late final getTodos = ref.read(getTodosProvider);
  var _completedCount = 0;
  int get completedCount => _completedCount;

  Future<void> loadTodos() async {
    state = const AsyncLoading();
    // await Future.delayed(const Duration(seconds: 1));
    final stateOrFailure = await ref.read(getTodosProvider).call();
    stateOrFailure.fold((error) {
      return 'error';
    }, (todos) {
      state = AsyncValue.data(todos);
      _completedCount = 0;
      for (var element in state.value!) {
        if (element.completed == true) {
          _completedCount++;
        }
      }
    });
  }

  Future<void> saveTodo(Todo todo) async {
    final stateOrFailure = await ref.read(saveTodoProvider).call(todo);
    stateOrFailure.fold((error) {
      return 'error';
    }, (id) {
      return null;
    });
    await loadTodos();
  }

  Future<void> deleteTodo(int id) async {
    final stateOrFailure = await ref.read(deleteTodoProvider).call(id);
    stateOrFailure.fold((error) {
      return 'error';
    }, (id) {
      return null;
    });
    await loadTodos();
  }

  Future<void> fillMocks() async {
    await ref.read(localDataSourceProvider).fillWithMocks();
    await loadTodos();
  }
}

final todosListState =
    StateNotifierProvider<TodosStateNotifier, AsyncValue<List<Todo>>>(
        (ref) => TodosStateNotifier(ref));
