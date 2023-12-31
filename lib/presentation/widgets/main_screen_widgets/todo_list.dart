import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yandex_flutter_task/core/localization/l10n/all_locale.dart';
import 'package:yandex_flutter_task/core/navigation/provider.dart';
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
            child: AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: todoList.length,
                itemBuilder: (_, final int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 750),
                    child: SlideAnimation(
                      verticalOffset: 100,
                      child: FadeInAnimation(
                        duration: const Duration(seconds: 1),
                        child: TodoTile(
                          todo: todoList[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
                ref.read(appNavigatorProvider).goToCreateTask();
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
