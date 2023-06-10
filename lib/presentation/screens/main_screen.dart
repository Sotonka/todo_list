import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/test_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosListState);
    final model = ref.read(todosListModel);
    return Scaffold(
      body: Column(
        children: [
          for (final todo in todos) Text(todo.body),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        model.saveTodo(Todo(id: 1, body: 'body'));
      }),
    );
  }
}
