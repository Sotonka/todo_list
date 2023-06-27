import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/app_router.dart';
import 'package:yandex_flutter_task/core/localization/l10n/all_locale.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
import 'package:yandex_flutter_task/presentation/providers/edit_todo_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/todo_tile.dart';

class TodoListWidget extends ConsumerWidget {
  final TodoList todoList;

  const TodoListWidget({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return Column(
      children: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: themeColors.backSecondary,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              controller: ScrollController(),
              shrinkWrap: true,
              itemCount: todoList.length,
              itemBuilder: (_, final int index) {
                return TodoTile(
                  todo: todoList[index],
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 14, left: 52),
            child: InkWell(
              onTap: () {
                ref.read(todoEditProvider.notifier).initTodo(null);
                ref.read(todoEditProvider.notifier).createNewTodo();
                Navigator.of(context).pushNamed(AppRouter.todoScreen);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: themeColors.labelTetriary,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    AllLocale.of(context).mainListNew,
                    style: theme.primaryTextTheme.bodyMedium!.copyWith(
                      color: themeColors.labelTetriary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
