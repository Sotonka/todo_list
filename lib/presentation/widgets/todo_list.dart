import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_tile.dart';

class TodoList extends StatelessWidget {
  final Iterable<Todo> iterable;
  const TodoList({
    super.key,
    required this.iterable,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          for (var todo in iterable) TodoTile(todo: todo),
        ],
      ),
    );
  }
}
