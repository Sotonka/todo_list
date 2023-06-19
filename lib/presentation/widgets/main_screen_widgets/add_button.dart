import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/app_router.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class AddTodoButtonWidget extends ConsumerWidget {
  const AddTodoButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return SizedBox(
      height: 56,
      width: 56,
      child: FloatingActionButton(
        backgroundColor: themeColors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          ref.read(todoInfoProvider.notifier).initTodo(
                const Todo(body: ''),
              );

          Navigator.of(context).pushNamed(AppRouter.todoScreen);
        },
        child: AppIcons.add(
          color: themeColors.white,
        ),
      ),
    );
  }
}
