import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final items = ['Нет', 'Низкий', 'Высокий'];
    final state = ref.watch(todoInfoNotifierProvider);
    final stateNotifier = ref.read(todoInfoNotifierProvider.notifier);

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
              onTap: () {},
              child: AppIcons.close(
                height: 14,
                width: 14,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: Text('СОХРАНИТЬ'),
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
                          child: TextFormField(
                            maxLines: 1000,
                            minLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text('Важность'),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 164,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                        iconDisabledColor: Colors.transparent,
                        iconEnabledColor: Colors.transparent,
                        value: items[0],
                        items: items
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (_) {},
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
                  const SizedBox(height: 8),
                  const Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Сделать до'),
                          state.deadline != null
                              ? Text(state.deadline.toString())
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
                  const Divider(),
                  const SizedBox(height: 22),
                  Text('Удалить'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
