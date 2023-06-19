import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
import 'package:yandex_flutter_task/domain/usecases/provider.dart';
import 'package:yandex_flutter_task/presentation/providers/filter_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/state/state.dart';

class TodoListViewModel extends StateNotifier<State<TodoList>> {
  TodoListViewModel(this.ref) : super(const State.init()) {
    getTodos();
  }

  final Ref ref;

  getTodos() async {
    state = const State.loading();
    final stateOrException = await ref.read(getTodosProvider).call();
    stateOrException.fold((error) {
      state = State.error(error);
    }, (todoList) {
      state = State.success(todoList);
    });
  }

  patchTodos(TodoList todos) async {
    state = const State.loading();
    final stateOrException =
        await ref.read(patchTodosProvider).call(todos, state.data!.revision);
    stateOrException.fold((error) {
      state = State.error(error);
    }, (todoList) {
      state = State.success(todoList);
    });
  }

  createTodo(Todo todo) async {
    final stateOrException =
        await ref.read(createTodoProvider).call(todo, state.data!.revision);
    stateOrException.fold((error) {
      state = State.error(error);
    }, (newTodo) {
      state = State.success(state.data!.addTodo(newTodo));
    });
  }

  updateTodo(Todo todo) async {
    final stateOrException =
        await ref.read(updateTodoProvider).call(todo, state.data!.revision);
    stateOrException.fold((error) {
      state = State.error(error);
    }, (newTodo) {
      state = State.success(state.data!.updateTodo(newTodo));
    });
  }

  deleteTodo(String id) async {
    final stateOrException =
        await ref.read(deleteTodoProvider).call(id, state.data!.revision);
    stateOrException.fold((error) {
      state = State.error(error);
    }, (newTodo) {
      state = State.success(state.data!.deleteTodo(newTodo));
    });
  }

  completeToggleTodo(Todo todo) {
    final newTodo = todo.copyWith(
      done: !todo.done,
      changed_at: DateTime.now().millisecondsSinceEpoch,
    );
    updateTodo(newTodo);
  }

  getCompleteCount() {
    return state.data?.completedTodoCount;
  }
}

final todoListProvider =
    StateNotifierProvider.autoDispose<TodoListViewModel, State<TodoList>>(
        (ref) {
  return TodoListViewModel(ref);
});

final filteredTodoListProvider = Provider.autoDispose<State<TodoList>>((ref) {
  final filterType = ref.watch(filterProvider);
  final todoListState = ref.watch(todoListProvider);

  return todoListState.when(
    init: () => const State.init(),
    success: (todoList) {
      switch (filterType) {
        case FilterType.all:
          return State.success(todoList);
        case FilterType.completed:
          return State.success(
            todoList.filterByCompleted(),
          );
        case FilterType.incompleted:
          return State.success(
            todoList.filterByIncompleted(),
          );
      }
    },
    loading: () => const State.loading(),
    error: (exception) => State.error(exception),
  );
});
