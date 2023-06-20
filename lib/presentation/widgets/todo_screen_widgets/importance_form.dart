import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/core/localization/l10n/all_locale.dart';
import 'package:yandex_flutter_task/presentation/providers/edit_todo_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class ImportanceFormWidget extends ConsumerWidget {
  const ImportanceFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final state = ref.watch(todoEditProvider);
    final stateNotifier = ref.read(todoEditProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AllLocale.of(context).todoFormImportance,
          style: theme.primaryTextTheme.bodyMedium!
              .copyWith(color: themeColors.labelPrimary),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 164,
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              elevation: 1,
              iconDisabledColor: Colors.transparent,
              iconEnabledColor: Colors.transparent,
              dropdownColor: themeColors.backElevated,
              value: state.importance == 'important'
                  ? AllLocale.of(context).todoImportanceHigh
                  : state.importance == 'low'
                      ? AllLocale.of(context).todoImportanceLow
                      : AllLocale.of(context).todoImportanceNo,
              items: [
                AllLocale.of(context).todoImportanceNo,
                AllLocale.of(context).todoImportanceLow,
                AllLocale.of(context).todoImportanceHigh,
              ]
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: item == AllLocale.of(context).todoImportanceHigh
                          ? RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: AppIcons.alert(),
                                    ),
                                  ),
                                  TextSpan(
                                    text: item,
                                    style: theme.primaryTextTheme.bodyMedium!
                                        .copyWith(color: themeColors.red),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              item,
                              style: theme.primaryTextTheme.bodyMedium!
                                  .copyWith(color: themeColors.labelTetriary),
                            ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                stateNotifier.updateImportance(
                  value ?? AllLocale.of(context).todoImportanceNo,
                  AllLocale.of(context).todoImportanceNo,
                  AllLocale.of(context).todoImportanceHigh,
                  AllLocale.of(context).todoImportanceLow,
                );
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.only(left: -16),
                hintText: '',
                hoverColor: Colors.transparent,
                filled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
