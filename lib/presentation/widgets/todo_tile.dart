import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  const TodoTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return Dismissible(
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
      direction: DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.endToStart: 0.2,
      },
      key: UniqueKey(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 86,
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
              top: 15,
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
                      Container(
                        color: Colors.red,
                        height: 18,
                        width: 18,
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                todo.body,
                                textAlign: TextAlign.left,
                                textHeightBehavior: const TextHeightBehavior(
                                  applyHeightToLastDescent: false,
                                ),
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: theme.primaryTextTheme.bodyMedium!
                                    .copyWith(color: themeColors.labelPrimary),
                              ),
                            ),
                            todo.deadline != null
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      'дата',
                                      style: theme.primaryTextTheme.bodySmall!
                                          .copyWith(
                                              color: themeColors.labelTetriary),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
                AppIcons.infoOutline(
                  color: themeColors.labelTetriary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
