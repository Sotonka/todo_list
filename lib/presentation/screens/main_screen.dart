import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/add_button.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/app_bar_widget.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/todo_list.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final todosState = ref.watch(todosListState);

    return Scaffold(
      backgroundColor: themeColors.backPrimary,
      body: CustomScrollView(
        slivers: [
          const MainAppBarWidget(),
          todosState.when(
            loading: () {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
            data: (data) {
              return data.isEmpty
                  ? SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Text(
                            'Пусто :(',
                            style: TextStyle(color: themeColors.labelPrimary),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              ref.read(todosListState.notifier).fillMocks();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              color: themeColors.blue,
                              child: const Text('~заполнить данными~'),
                            ),
                          ),
                        ],
                      ),
                    )
                  : _Core(data: data);
            },
            error: (_, __) {
              return const SliverToBoxAdapter();
            },
          ),
        ],
      ),
      floatingActionButton: const AddTodoButtonWidget(),
    );
  }
}

class _Core extends StatelessWidget {
  final List<Todo> data;
  const _Core({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 16,
      ),
      sliver: SliverToBoxAdapter(
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: themeColors.backSecondary,
              child: TodoList(
                iterable: data,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
