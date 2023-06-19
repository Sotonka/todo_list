import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class ImportanceFormWidget extends ConsumerWidget {
  const ImportanceFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final state = ref.watch(todoInfoProvider);
    final stateNotifier = ref.read(todoInfoProvider.notifier);
    final items = ['Нет', 'Низкий', 'Высокий'];
    bool isSelected = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.todoFormImportance,
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
              value: state.importance == 'no'
                  ? 'Нет'
                  : state.importance == 'low'
                      ? 'Низкий'
                      : 'Высокий',
              items: items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: item == 'Высокий'
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
                                  .copyWith(
                                      color: isSelected == true
                                          ? themeColors.labelPrimary
                                          : themeColors.labelTetriary),
                            ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                isSelected = true;
                stateNotifier.updateImportance(value ?? 'нет');
              },
              onTap: () {
                isSelected = false;
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
