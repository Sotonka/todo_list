import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/app_router.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_info_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/visibility_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/sliver_title_delegate.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_list.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final todosState = ref.watch(todosListState);
    final completedCount = ref.watch(todosListState.notifier).completedCount;
    final visibilityState = ref.watch(visibilityStateNotifierProvider);
    final visibilityProvider =
        ref.watch(visibilityStateNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: themeColors.backPrimary,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverTitleDelegate(
              systemBarHeight: MediaQuery.of(context).padding.top,
              bigTitleStyle: theme.primaryTextTheme.headlineLarge!
                  .copyWith(color: themeColors.labelPrimary),
              smallTitleStyle: theme.primaryTextTheme.headlineMedium!
                  .copyWith(color: themeColors.labelPrimary),
              context: context,
              onHidePressed: visibilityProvider.toggle,
              completedCount: completedCount,
              isHidden: visibilityState,
            ),
          ),
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
                          const Text('Пусто :('),
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
      floatingActionButton: SizedBox(
        height: 56,
        width: 56,
        child: FloatingActionButton(
          backgroundColor: themeColors.blue,
          shape: const CircleBorder(),
          onPressed: () {
            ref.read(todoInfoNotifierProvider.notifier).initTodo(
                  const Todo(body: ''),
                );

            Navigator.of(context).pushNamed(AppRouter.todoScreen);
          },
          child: AppIcons.add(
            color: themeColors.white,
          ),
        ),
      ),
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
