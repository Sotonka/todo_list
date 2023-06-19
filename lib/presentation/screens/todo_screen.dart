// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:intl/intl.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final items = ['Нет', 'Низкий', 'Высокий'];
    final state = ref.watch(todoInfoProvider);
    final stateNotifier = ref.read(todoInfoProvider.notifier);

    return Scaffold(
      backgroundColor: themeColors.backPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
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
                  ),
                  const SizedBox(height: 28),
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
                                                padding: const EdgeInsets.only(
                                                    right: 6),
                                                child: AppIcons.alert(),
                                              ),
                                            ),
                                            TextSpan(
                                              text: item,
                                              style: theme
                                                  .primaryTextTheme.bodyMedium!
                                                  .copyWith(
                                                      color: themeColors.red),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        item,
                                        style: theme
                                            .primaryTextTheme.bodyMedium!
                                            .copyWith(
                                                color:
                                                    themeColors.labelPrimary),
                                      ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          stateNotifier.updateImportance(value ?? 'нет');
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
                  const SizedBox(height: 16),
                  Divider(color: themeColors.supportSeparator),
                  const SizedBox(height: 16),
                  Row(
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
                                    DateFormat('dd MM yyy')
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
                                          dialogBackgroundColor:
                                              themeColors.backSecondary,
                                          colorScheme: ColorScheme.light(
                                            primary: themeColors.blue!,
                                            onPrimary: themeColors.white!,
                                            onSurface:
                                                themeColors.labelPrimary!,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    cancelText: AppStrings.todoCalendarCancel
                                        .toUpperCase(),
                                    confirmText: AppStrings.todoCalendarDone
                                        .toUpperCase(),
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
                  ),
                  const SizedBox(height: 40),
                  Divider(color: themeColors.supportSeparator),
                  const SizedBox(height: 16),
                  InkWell(
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
                          color: state.id == null
                              ? themeColors.labelDisable
                              : themeColors.red,
                        ),
                        const SizedBox(width: 17),
                        Text(
                          AppStrings.todoDelete,
                          style: theme.primaryTextTheme.bodyMedium!.copyWith(
                            color: state.id == null
                                ? themeColors.labelDisable
                                : themeColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
