import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/localization/l10n/all_locale.dart';
import 'package:yandex_flutter_task/presentation/providers/edit_todo_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class TodoAppBarWidget extends ConsumerWidget {
  const TodoAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final stateNotifier = ref.read(todoEditProvider.notifier);

    return SliverAppBar(
      backgroundColor: themeColors.backPrimary,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      leading: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          stateNotifier.clearField();
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
            stateNotifier.saveTodo();
            stateNotifier.clearField();
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                AllLocale.of(context).todoSave.toUpperCase(),
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
