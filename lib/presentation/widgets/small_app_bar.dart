import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class SmallAppBar extends SliverPersistentHeaderDelegate {
  static const bigTitleOffset = 53;
  final double systemBarHeight;
  final VoidCallback onClosePressed;
  final VoidCallback onSavePressed;
  final BuildContext context;

  @override
  double get maxExtent => systemBarHeight + 66;

  @override
  double get minExtent => systemBarHeight + 30;

  SmallAppBar({
    required this.systemBarHeight,
    required this.onClosePressed,
    required this.onSavePressed,
    required this.context,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return Container(
      color: Colors.red,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
