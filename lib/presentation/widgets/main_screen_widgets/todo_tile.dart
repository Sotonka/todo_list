// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/app_router.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TodoTile extends ConsumerWidget {
  final Todo todo;

  const TodoTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final todosListStateNotifier = ref.read(todosListState.notifier);

    return _DismissibleElement(
        todo: todo,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 150,
            minHeight: 48,
            maxWidth: double.infinity,
            minWidth: double.infinity,
          ),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 14,
                bottom: 12,
                left: 19,
                right: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(appLoggerProvider)
                                  .i('UI: <id: ${todo.id}> : complete action');
                              todosListStateNotifier.saveTodo(
                                todo.copyWith(completed: !todo.completed),
                              );
                            },
                            child: todo.completed
                                ? Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                      color: themeColors.green,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.check,
                                        size: 18,
                                        color: themeColors.backSecondary,
                                      ),
                                    ),
                                  )
                                : todo.importance == 'high'
                                    ? Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                          color: themeColors.red!
                                              .withOpacity(0.14),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          border: Border.all(
                                              color: themeColors.red!,
                                              width: 2),
                                        ),
                                      )
                                    : Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          border: Border.all(
                                              color:
                                                  themeColors.supportSeparator!,
                                              width: 2),
                                        ),
                                      ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: _TileTitle(todo: todo),
                              ),
                              todo.deadline != null
                                  ? Text(
                                      DateFormat.yMMMMd(
                                              Localizations.localeOf(context)
                                                  .toString())
                                          .format(
                                        todo.deadline!,
                                      ),
                                      style: theme.primaryTextTheme.bodySmall!
                                          .copyWith(color: themeColors.blue),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(todoInfoProvider.notifier).initTodo(todo);

                      ref.read(appLoggerProvider).i(
                          'UI: <id: ${todo.id}> : transition to todo info screen');

                      Navigator.of(context).pushNamed(AppRouter.todoScreen);
                    },
                    child: AppIcons.infoOutline(
                      color: themeColors.labelTetriary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _DismissibleElement extends ConsumerWidget {
  final Widget child;
  final Todo todo;
  const _DismissibleElement({
    required this.child,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final todosListStateNotifier = ref.read(todosListState.notifier);

    return Dismissible(
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          ref
              .read(appLoggerProvider)
              .i('UI: <id: ${todo.id}> : complete draggable action');
          todosListStateNotifier.saveTodo(
            todo.copyWith(completed: true),
          );
          return false;
        } else if (direction == DismissDirection.endToStart) {
          return true;
        }
        return null;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          ref
              .read(appLoggerProvider)
              .i('UI: <id: ${todo.id}> : delete draggable action');
          todosListStateNotifier.deleteTodo(todo.id!);
        }
      },
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: themeColors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppIcons.check(
              color: themeColors.white,
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: themeColors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppIcons.delete(
              color: themeColors.white,
            ),
          ],
        ),
      ),
      direction: todo.completed
          ? DismissDirection.endToStart
          : DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.endToStart: 0.2,
      },
      key: UniqueKey(),
      child: child,
    );
  }
}

class _TileTitle extends StatelessWidget {
  final Todo todo;
  const _TileTitle({required this.todo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          todo.importance == 'high' && todo.completed == false
              ? WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: AppIcons.alert(),
                  ),
                )
              : todo.importance == 'low' && todo.completed == false
                  ? WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: AppIcons.arrowDown(),
                      ),
                    )
                  : const WidgetSpan(child: SizedBox.shrink()),
          TextSpan(
            text: todo.body,
            style: todo.completed
                ? theme.primaryTextTheme.bodyMedium!
                    .copyWith(color: themeColors.labelTetriary)
                    .copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: themeColors.labelTetriary,
                    )
                : theme.primaryTextTheme.bodyMedium!
                    .copyWith(color: themeColors.labelPrimary),
          ),
        ],
      ),
    );
  }
}
