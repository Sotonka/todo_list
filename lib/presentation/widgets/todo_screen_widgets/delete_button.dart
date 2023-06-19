import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class DeleteButtonWidget extends ConsumerWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final stateNotifier = ref.read(todoInfoProvider.notifier);
    final state = ref.watch(todoInfoProvider);

    return InkWell(
      onTap: () {
        if (state.id != null) {
          FocusManager.instance.primaryFocus?.unfocus();
          stateNotifier.formClear();
          ref.read(todosListState.notifier).deleteTodo(state.id!);
          Navigator.pop(context);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcons.delete(
            color:
                state.id == null ? themeColors.labelDisable : themeColors.red,
          ),
          const SizedBox(width: 17),
          Text(
            AppStrings.todoDelete,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              color:
                  state.id == null ? themeColors.labelDisable : themeColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
