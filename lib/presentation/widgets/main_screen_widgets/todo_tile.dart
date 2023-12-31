import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yandex_flutter_task/core/constants.dart';
import 'package:yandex_flutter_task/core/firebase_remote_config/firebase_remote_config.dart';
import 'package:yandex_flutter_task/core/navigation/provider.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/edit_todo_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_list_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final todoListNotifier = ref.read(todoListProvider.notifier);

    return Dismissible(
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          todoListNotifier.completeToggleTodo(todo);

          return false;
        } else if (direction == DismissDirection.endToStart) {
          return true;
        }
        return null;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          todoListNotifier.deleteTodo(todo.id);
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
      direction:
          todo.done ? DismissDirection.endToStart : DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.endToStart: 0.2,
      },
      key: ValueKey(todo.id.toString()),
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
                _Core(todo: todo),
                _UpdateButton(todo: todo),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UpdateButton extends ConsumerWidget {
  final Todo todo;
  const _UpdateButton({required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return InkWell(
      onTap: () {
        ref.read(todoEditProvider.notifier).initTodo(todo);
        ref.read(appNavigatorProvider).goToEditTask(todo.id);
      },
      child: AppIcons.infoOutline(
        color: themeColors.labelTetriary,
      ),
    );
  }
}

class _Core extends ConsumerWidget {
  final Todo todo;
  const _Core({required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final todoListNotifier = ref.read(todoListProvider.notifier);
    final firebaseRemoteConfigService =
        ref.watch(firebaseRemoteConfigServiceProvider);

    return ValueListenableBuilder(
      valueListenable: firebaseRemoteConfigService.colorNotifier,
      builder: (context, color, _) {
        return Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: InkWell(
                  onTap: () {
                    todoListNotifier.completeToggleTodo(todo);
                  },
                  child: todo.done
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
                      : todo.importance == Api.importanceImportant
                          ? Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: color == null
                                    ? themeColors.importance!.withOpacity(0.14)
                                    : HexColor.fromHex(color).withOpacity(0.14),
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: color == null
                                        ? themeColors.importance!
                                        : HexColor.fromHex(color),
                                    width: 2),
                              ),
                            )
                          : Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: themeColors.supportSeparator!,
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
                      child: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            todo.importance == Api.importanceImportant &&
                                    todo.done == false
                                ? WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: AppIcons.alert(
                                        color: color == null
                                            ? themeColors.importance
                                            : HexColor.fromHex(color),
                                      ),
                                    ),
                                  )
                                : todo.importance == Api.importanceLow &&
                                        todo.done == false
                                    ? WidgetSpan(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: AppIcons.arrowDown(),
                                        ),
                                      )
                                    : const WidgetSpan(
                                        child: SizedBox.shrink()),
                            TextSpan(
                              text: todo.text,
                              style: todo.done
                                  ? theme.primaryTextTheme.bodyMedium!
                                      .copyWith(
                                          color: themeColors.labelTetriary)
                                      .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor:
                                            themeColors.labelTetriary,
                                      )
                                  : theme.primaryTextTheme.bodyMedium!.copyWith(
                                      color: themeColors.labelPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    todo.deadline != null
                        ? Text(
                            DateFormat.yMMMMd(
                                    Localizations.localeOf(context).toString())
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                    todo.deadline!)),
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
        );
      },
    );
  }
}
