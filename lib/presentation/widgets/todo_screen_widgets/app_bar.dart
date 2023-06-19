import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class TodoAppBarWidget extends ConsumerWidget {
  const TodoAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final stateNotifier = ref.read(todoInfoProvider.notifier);
    final state = ref.watch(todoInfoProvider);

    return SliverAppBar(
      backgroundColor: themeColors.backPrimary,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      leading: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          stateNotifier.formClear();
          Navigator.pop(context);
        },
        child: Center(
          child: AppIcons.close(
            color: themeColors.labelPrimary,
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            ref.read(todosListState.notifier).saveTodo(state);
            stateNotifier.formClear();
            Navigator.pop(context);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                AppStrings.todoSave.toUpperCase(),
                style: theme.primaryTextTheme.titleMedium!
                    .copyWith(color: themeColors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
