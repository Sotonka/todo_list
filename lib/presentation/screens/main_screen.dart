import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/sliver_title_delegate.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_list.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final state = ref.watch(todosListState);
    final completedCount = ref.watch(todosListState.notifier).completedCount;

    return Scaffold(
      backgroundColor: themeColors.backPrimary,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverTitleDelegate(
              systemBarHeight: MediaQuery.of(context).padding.top,
              bigTitleStyle: theme.primaryTextTheme.headlineLarge!,
              smallTitleStyle: theme.primaryTextTheme.headlineMedium!,
              context: context,
              onHidePressed: () {},
              completedCount: completedCount,
            ),
          ),
          state.when(
            loading: () {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            data: (data) {
              return _Core(data: data);
            },
            // TODO
            error: (_, __) {
              return const SliverToBoxAdapter();
            },
          ),
        ],
      ),
    );
  }
}

class _Core extends StatelessWidget {
  final List<Todo>? data;
  const _Core({this.data});

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
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: themeColors.backSecondary,
          child: TodoList(
            iterable: data!,
          ),
        ),
      ),
    );
  }
}
