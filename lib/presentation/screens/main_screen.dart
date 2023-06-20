import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_list_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/add_button.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/app_bar_widget.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/error.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/progress_indicator.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/todo_list.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return Scaffold(
      backgroundColor: themeColors.backPrimary,
      body: const CustomScrollView(
        slivers: [
          MainAppBarWidget(),
          SliverPadding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: _Core(),
            ),
          ),
        ],
      ),
      floatingActionButton: const AddTodoButtonWidget(),
    );
  }
}

class _Core extends ConsumerWidget {
  const _Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(filteredTodoListProvider).maybeWhen(
          success: (content) => TodoListWidget(todoList: content),
          error: (e) => ErrorMessageWidget(
            message: e.toString(),
          ),
          orElse: () => const ProgressIndicatorWidget(),
        );
  }
}
