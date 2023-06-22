import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/localization/l10n/all_locale.dart';
import 'package:yandex_flutter_task/presentation/providers/edit_todo_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:intl/intl.dart';

class DeadlineFormWidget extends ConsumerWidget {
  const DeadlineFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final state = ref.watch(todoEditProvider);
    final stateNotifier = ref.read(todoEditProvider.notifier);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AllLocale.of(context).todoFormDeadline,
              style: theme.primaryTextTheme.bodyMedium!
                  .copyWith(color: themeColors.labelPrimary),
            ),
            state.deadline != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMMd(
                              Localizations.localeOf(context).toString())
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              state.deadline!)),
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
          value: stateNotifier.isDeadlineSet,
          onChanged: (value) async {
            value == false
                ? stateNotifier.updateDeadline(null)
                : await _showCalendar(context, ref);
          },
        ),
      ],
    );
  }
}

Future<void> _showCalendar(BuildContext context, WidgetRef ref) async {
  final theme = Theme.of(context);
  final themeColors = theme.extension<AppThemeColors>()!;
  DateTime? deadline = await showDatePicker(
    locale: Localizations.localeOf(context),
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
    cancelText: AllLocale.of(context).todoCalendarCancel.toUpperCase(),
    confirmText: AllLocale.of(context).todoCalendarDone.toUpperCase(),
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(
      const Duration(days: 1780),
    ),
  );
  if (deadline != null) {
    ref
        .read(todoEditProvider.notifier)
        .updateDeadline(deadline.millisecondsSinceEpoch);
  } else {
    ref.read(todoEditProvider.notifier).updateDeadline(null);
  }
}
