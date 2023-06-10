import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/usecases/get_todos.dart';
import 'package:yandex_flutter_task/domain/usecases/provider.dart';
import 'package:yandex_flutter_task/domain/usecases/save_todo.dart';

class TodosStateNotifier extends StateNotifier<List<Todo>> {
  TodosStateNotifier(this.ref) : super(const []) {
    loadTodos();
  }

  final Ref ref;
  late final getTodos = ref.read(getTodosProvider);

  Future<void> loadTodos() async {
    final stateOrFailure =
        await ref.read(getTodosProvider).call(const Params());
    stateOrFailure.fold((error) {}, (todos) {
      state = todos;
    });
  }

  Future<void> saveTodo(Todo todo) async {
    final stateOrFailure =
        await ref.read(saveTodoProvider).call(SaveTodoParams(todo: todo));
    stateOrFailure.fold((error) {}, (r) {});
    await loadTodos();
  }
}

final todosListState = StateNotifierProvider<TodosStateNotifier, List<Todo>>(
    (ref) => TodosStateNotifier(ref));

final todosListModel = Provider<TodosStateNotifier>((ref) {
  return ref.watch(todosListState.notifier);
});
