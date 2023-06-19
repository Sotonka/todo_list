import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class BodyFormWidget extends ConsumerWidget {
  const BodyFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final stateNotifier = ref.read(todoInfoProvider.notifier);

    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: themeColors.backSecondary,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
              minWidth: double.infinity,
              maxHeight: double.infinity,
              minHeight: 104,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (value) {
                  stateNotifier.updateBody(value);
                },
                onFieldSubmitted: (value) {
                  stateNotifier.updateBody(value);
                },
                controller: stateNotifier.bodyController,
                style: theme.primaryTextTheme.bodyMedium!
                    .copyWith(color: themeColors.labelPrimary),
                decoration: InputDecoration.collapsed(
                  hintText: AppStrings.todoFormHint,
                  hintStyle: theme.primaryTextTheme.bodyMedium!
                      .copyWith(color: themeColors.labelTetriary),
                ),
                maxLines: 1000,
                minLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
