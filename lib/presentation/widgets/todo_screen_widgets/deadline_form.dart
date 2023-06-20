import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:intl/intl.dart';

class DeadlineFormWidget extends ConsumerWidget {
  const DeadlineFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final state = ref.watch(todoInfoProvider);
    final stateNotifier = ref.read(todoInfoProvider.notifier);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.todoFormDeadline,
              style: theme.primaryTextTheme.bodyMedium!
                  .copyWith(color: themeColors.labelPrimary),
            ),
            state.deadline != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMMd(
                              Localizations.localeOf(context).toString())
                          .format(state.deadline!),
                      style: theme.primaryTextTheme.bodySmall!
                          .copyWith(color: themeColors.blue),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        Switch(
          activeTrackColor: themeColors.blue!.withOpacity(0.3),
          activeColor: themeColors.blue,
          inactiveThumbColor: themeColors.backElevated,
          inactiveTrackColor: themeColors.supportOverlay,
          value: state.deadline != null ? true : false,
          onChanged: (value) async {
            value == false
                ? stateNotifier.updateDeadline(null)
                : stateNotifier.updateDeadline(
                    await showDatePicker(
                      locale: const Locale('ru', 'RU'),
                      builder: (context, child) {
                        return Theme(
                          data: theme.copyWith(
                            dialogBackgroundColor: themeColors.backSecondary,
                            colorScheme: ColorScheme.light(
                              primary: themeColors.blue!,
                              onPrimary: themeColors.white!,
                              onSurface: themeColors.labelPrimary!,
                            ),
                          ),
                          child: child!,
                        );
                      },
                      cancelText: AppStrings.todoCalendarCancel.toUpperCase(),
                      confirmText: AppStrings.todoCalendarDone.toUpperCase(),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 1780),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
