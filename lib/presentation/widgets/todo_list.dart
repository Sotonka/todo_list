import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/visibility_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_tile.dart';

class TodoList extends ConsumerWidget {
  final Iterable<Todo> iterable;

  const TodoList({
    super.key,
    required this.iterable,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibilityProvider = ref.watch(visibilityStateNotifierProvider);
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          for (var todo in iterable)
            if (visibilityProvider == false || todo.completed == false)
              TodoTile(
                todo: todo,
              ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14, left: 52),
              child: Text(
                AppStrings.mainListNew,
                style: theme.primaryTextTheme.bodyMedium!
                    .copyWith(color: themeColors.labelTetriary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
