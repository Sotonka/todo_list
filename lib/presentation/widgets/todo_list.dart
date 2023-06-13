import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_tile.dart';

class TodoList extends ConsumerWidget {
  final Iterable<Todo> iterable;

  const TodoList({
    super.key,
    required this.iterable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          for (var todo in iterable)
            TodoTile(
              todo: todo,
              onComplete: () {
                ref.read(todosListState.notifier).saveTodo(
                      Todo(
                        id: todo.id,
                        body: todo.body,
                        deadline: todo.deadline,
                        importance: todo.importance,
                        completed: true,
                      ),
                    );
              },
              onDelete: () {
                ref.read(todosListState.notifier).deleteTodo(todo.id!);
              },
            ),
        ],
      ),
    );
  }
}
