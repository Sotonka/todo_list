import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';

class TodoInfoNotifier extends StateNotifier<Todo> {
  TodoInfoNotifier(this.ref) : super(const Todo(body: ''));

  final Ref ref;

  final _bodyController = TextEditingController();
  TextEditingController get bodyController => _bodyController;
  set bodyControllerText(String text) {
    _bodyController.text = text;
  }

  void initTodo(Todo initial) {
    ref.read(appLoggerProvider).i('PROVIDER: initialize todo with ${initial}');
    state = initial;
    if (state.body.isNotEmpty) {
      _bodyController.text = state.body;
    }
  }

  void updateBody(String body) {
    state = state.copyWith(body: body);
  }

  void updateDeadline(DateTime? deadline) {
    state = state.copyWith(deadline: deadline);
  }

  void updateImportance(String importance) {
    switch (importance.toLowerCase()) {
      case 'нет':
        state = state.copyWith(importance: 'no');

      case 'низкий':
        state = state.copyWith(importance: 'low');

      case 'высокий':
        state = state.copyWith(importance: 'high');

      default:
        state = state.copyWith(importance: 'no');
    }
  }

  void formClear() {
    _bodyController.clear();
  }

  @override
  void dispose() {
    _bodyController.dispose();
    super.dispose();
  }
}

final todoInfoProvider = StateNotifierProvider<TodoInfoNotifier, Todo>(
    (ref) => TodoInfoNotifier(ref));
