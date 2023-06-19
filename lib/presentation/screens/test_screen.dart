import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_list_provider.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ref.watch(filteredTodoListProvider).maybeWhen(
                success: (content) => Text(content.toString()),
                error: (e) => Text(e.toString()),
                orElse: () => Container(),
              ),
          InkWell(
            onTap: () {
              ref.read(todoListProvider.notifier).getTodos();
            },
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              height: 50,
              width: double.infinity,
              child: Text('getTodos'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              height: 50,
              width: double.infinity,
              child: Text('patchTodos'),
            ),
          ),
          InkWell(
            onTap: () {
              ref.read(todoListProvider.notifier).createTodo(Todo(
                    id: const Uuid().v4(),
                    text: 'text',
                    last_updated_by: 'last_updated_by',
                    changed_at: DateTime.now().millisecondsSinceEpoch,
                    created_at: DateTime.now().millisecondsSinceEpoch,
                  ));
            },
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              height: 50,
              width: double.infinity,
              child: Text('createTodo'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              height: 50,
              width: double.infinity,
              child: Text('updateTodo'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              height: 50,
              width: double.infinity,
              child: Text('deleteTodo'),
            ),
          ),
        ],
      ),
    );
  }
}
