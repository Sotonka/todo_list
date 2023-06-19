import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/app_bar.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/body_form.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/deadline_form.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/delete_button.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/divider.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/importance_form.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return Scaffold(
      backgroundColor: themeColors.backPrimary,
      body: const CustomScrollView(
        slivers: [
          TodoAppBarWidget(),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyFormWidget(),
                  SizedBox(height: 28),
                  ImportanceFormWidget(),
                  SizedBox(height: 16),
                  DividerWidget(),
                  SizedBox(height: 16),
                  DeadlineFormWidget(),
                  SizedBox(height: 40),
                  DividerWidget(),
                  SizedBox(height: 16),
                  DeleteButtonWidget(),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
