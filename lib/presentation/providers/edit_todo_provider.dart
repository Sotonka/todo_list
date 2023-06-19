// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_list_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class TodoEditNotifier extends StateNotifier<Todo> {
  TodoEditNotifier(this.ref)
      : super(Todo(
          id: const Uuid().v4(),
          text: '',
          last_updated_by: 'last_updated_by',
          changed_at: DateTime.now().millisecondsSinceEpoch,
          created_at: DateTime.now().millisecondsSinceEpoch,
        ));

  final Ref ref;

  final _bodyController = TextEditingController();
  TextEditingController get bodyController => _bodyController;
  set bodyControllerText(String text) {
    _bodyController.text = text;
  }

  bool _isNew = true;
  bool get isNew => _isNew;
  bool _isDeadlineSet = false;
  bool get isDeadlineSet => _isDeadlineSet;

  void initTodo(Todo? initial) {
    if (initial != null) {
      _isNew = false;
      initial.deadline != null ? _isDeadlineSet = true : _isDeadlineSet = false;
      state = initial;
    } else {
      _isNew = true;
      _isDeadlineSet = false;
    }

    if (state.text.isNotEmpty) {
      _bodyController.text = state.text;
    }
  }

  void updateBody(String text) {
    state = state.copyWith(text: text);
  }

  void updateDeadline(int? deadline) {
    if (deadline == null) {
      _isDeadlineSet = false;
    } else {
      _isDeadlineSet = true;
    }
    state = state.copyWith(deadline: deadline);
  }

  void updateImportance(String importance) {
    switch (importance) {
      case AppStrings.todoImportanceNo:
        state = state.copyWith(importance: 'basic');

      case AppStrings.todoImportanceLow:
        state = state.copyWith(importance: 'low');

      case AppStrings.todoImportanceHigh:
        state = state.copyWith(importance: 'high');

      default:
        state = state.copyWith(importance: 'basic');
    }
  }

  void saveTodo() {
    if (_isNew) {
      ref.read(todoListProvider.notifier).createTodo(state);
    } else {
      ref.read(todoListProvider.notifier).updateTodo(state);
    }
  }

  void deleteTodo() {
    if (!_isNew) {
      ref.read(todoListProvider.notifier).deleteTodo(state.id);
    }
  }

  void clearField() {
    _isNew = true;
    _bodyController.clear();
    state = createNewTodo();
  }

  Todo createNewTodo() {
    _isNew = true;
    return (Todo(
      id: const Uuid().v4(),
      text: '',
      last_updated_by: 'last_updated_by',
      changed_at: DateTime.now().millisecondsSinceEpoch,
      created_at: DateTime.now().millisecondsSinceEpoch,
    ));
  }
}

final todoEditProvider = StateNotifierProvider<TodoEditNotifier, Todo>(
    (ref) => TodoEditNotifier(ref));
