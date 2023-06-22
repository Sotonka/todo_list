// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_flutter_task/core/constants.dart';
import 'package:yandex_flutter_task/core/device_info/device_id.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_list_provider.dart';

class TodoEditNotifier extends StateNotifier<Todo> {
  TodoEditNotifier(this.ref)
      : super(Todo(
          id: const Uuid().v4(),
          text: '',
          last_updated_by: '',
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

  void updateImportance(
    String importance,
    String importanceNo,
    String importanceImportant,
    String importanceLow,
  ) {
    if (importance == importanceNo) {
      state = state.copyWith(importance: Api.importanceBasic);
      return;
    }
    if (importance == importanceLow) {
      state = state.copyWith(importance: Api.importanceLow);
      return;
    }
    if (importance == importanceImportant) {
      state = state.copyWith(importance: Api.importanceImportant);
      return;
    }
    state = state.copyWith(importance: Api.importanceBasic);
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

  void clearField() async {
    _isNew = true;
    _bodyController.clear();
    state = await createNewTodo();
  }

  Future<Todo> createNewTodo() async {
    final deviceId = await DeviceId().deviceId;
    _isNew = true;
    return (Todo(
      id: const Uuid().v4(),
      text: '',
      last_updated_by: deviceId,
      changed_at: DateTime.now().millisecondsSinceEpoch,
      created_at: DateTime.now().millisecondsSinceEpoch,
    ));
  }
}

final todoEditProvider = StateNotifierProvider<TodoEditNotifier, Todo>(
    (ref) => TodoEditNotifier(ref));
