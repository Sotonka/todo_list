import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/widgets/sliver_title_delegate.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
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
                onHidePressed: () {}),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1000,
              width: 200,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
