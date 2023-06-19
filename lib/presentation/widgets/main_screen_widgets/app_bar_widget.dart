import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todos_provider.dart';
import 'package:yandex_flutter_task/presentation/providers/visibility_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/sliver_title_delegate.dart';

class MainAppBarWidget extends ConsumerWidget {
  const MainAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final completedCount = ref.watch(todosListState.notifier).completedCount;
    final visibilityState = ref.watch(visibilityProvider);
    final visibilityNotifier = ref.watch(visibilityProvider.notifier);

    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverTitleDelegate(
        systemBarHeight: MediaQuery.of(context).padding.top,
        bigTitleStyle: theme.primaryTextTheme.headlineLarge!
            .copyWith(color: themeColors.labelPrimary),
        smallTitleStyle: theme.primaryTextTheme.headlineMedium!
            .copyWith(color: themeColors.labelPrimary),
        context: context,
        onHidePressed: visibilityNotifier.toggle,
        completedCount: completedCount,
        isHidden: visibilityState,
      ),
    );
  }
}
