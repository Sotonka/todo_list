import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/edit_todo_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class DeleteButtonWidget extends ConsumerWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final stateNotifier = ref.read(todoEditProvider.notifier);

    return InkWell(
      onTap: () {
        stateNotifier.deleteTodo();
        FocusManager.instance.primaryFocus?.unfocus();
        stateNotifier.clearField();
        Navigator.pop(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcons.delete(
            color: stateNotifier.isNew
                ? themeColors.labelDisable
                : themeColors.red,
          ),
          const SizedBox(width: 17),
          Text(
            AppStrings.todoDelete,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              color: stateNotifier.isNew
                  ? themeColors.labelDisable
                  : themeColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
