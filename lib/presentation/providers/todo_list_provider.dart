// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
import 'package:yandex_flutter_task/domain/usecases/provider.dart';
import 'package:yandex_flutter_task/presentation/providers/filter_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/state/state.dart';

class TodoListViewModel extends StateNotifier<State<TodoList>> {
  TodoListViewModel(this.ref) : super(const State.init()) {
    getTodos();
    _todoDeleteSubsciption = todoDeleteStream.listen((id) async {
      state.whenOrNull(
        success: (list) async {
          await _deleteTodo(id);
        },
      );
    });
    _todoUpdateSubsciption = todoUpdateStream.listen((todo) async {
      state.whenOrNull(
        success: (list) {
          _updateTodo(todo);
        },
      );
    });
  }

  final Ref ref;
  final StreamController<String> _todoDeleteStreamController =
      StreamController.broadcast();
  Stream<String> get todoDeleteStream => _todoDeleteStreamController.stream;

  final StreamController<Todo> _todoUpdateStreamController =
      StreamController.broadcast();
  Stream<Todo> get todoUpdateStream => _todoUpdateStreamController.stream;

  late final StreamSubscription<String> _todoDeleteSubsciption;

  late final StreamSubscription<Todo> _todoUpdateSubsciption;

  getTodos() async {
    state = const State.loading();
    final stateOrException = await ref.read(getTodosProvider).call();
    stateOrException.fold((error) {
      ref.read(appLoggerProvider).e('PROVIDER: $error');
      state = State.error(error);
    }, (todoList) {
      ref
          .read(appLoggerProvider)
          .i('PROVIDER: todo Rev ${todoList.revision} loaded');
      state = State.success(todoList);
    });
  }

  patchTodos(TodoList todos) async {
    state = const State.loading();
    final stateOrException =
        await ref.read(patchTodosProvider).call(todos, state.data!.revision);
    stateOrException.fold((error) {
      ref.read(appLoggerProvider).e('PROVIDER: $error');
      state = State.error(error);
    }, (todoList) {
      ref
          .read(appLoggerProvider)
          .i('PROVIDER: todo Rev ${todoList.revision} patched');
      state = State.success(todoList);
    });
  }

  createTodo(Todo todo) async {
    final stateOrException =
        await ref.read(createTodoProvider).call(todo, state.data!.revision);
    stateOrException.fold((error) {
      ref.read(appLoggerProvider).e('PROVIDER: $error');
      state = State.error(error);
    }, (newTodo) {
      ref
          .read(appLoggerProvider)
          .i('PROVIDER: todo ${newTodo.id} has been saved');
      state = State.success(state.data!.addTodo(newTodo));
    });
  }

  updateTodo(Todo todo) async {
    state = State.success(state.data!.updateTodo(todo));
    _todoUpdateStreamController.add(todo);
  }

  _updateTodo(Todo todo) async {
    final revision = state.data!.revision - 1;

    final stateOrException =
        await ref.read(updateTodoProvider).call(todo, revision);
    stateOrException.fold((error) {
      ref.read(appLoggerProvider).e('PROVIDER: $error');
      state = State.error(error);
    }, (newTodo) {
      ref
          .read(appLoggerProvider)
          .i('PROVIDER: todo ${newTodo.id} has been updated');
    });
  }

  deleteTodo(String id) async {
    state = State.success(state.data!.deleteTodo(id));
    _todoDeleteStreamController.add(id);
  }

  _deleteTodo(String id) async {
    final revision = state.data!.revision - 1;
    final stateOrException = await ref.read(deleteTodoProvider).call(
          id,
          revision,
        );
    stateOrException.fold((error) {
      ref.read(appLoggerProvider).e('PROVIDER: $error');
      state = State.error(error);
    }, (newTodo) {
      ref
          .read(appLoggerProvider)
          .i('PROVIDER: todo ${newTodo.id} has been deleted');
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
