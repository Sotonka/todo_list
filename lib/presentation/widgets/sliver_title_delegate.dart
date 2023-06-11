import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class SliverTitleDelegate extends SliverPersistentHeaderDelegate {
  static const bigTitleOffset = 53;
  final double systemBarHeight;
  final TextStyle bigTitleStyle;
  final TextStyle smallTitleStyle;
  final double bigTitleHeight;
  final double smallTitleHeight;
  final VoidCallback onHidePressed;
  final bool isHidden;
  final int completedCount;
  final BuildContext context;

  @override
  double get maxExtent =>
      systemBarHeight + bigTitleOffset + bigTitleHeight * 2 + 30 + 32;

  @override
  double get minExtent => systemBarHeight + smallTitleHeight + 16 + 18;

  SliverTitleDelegate({
    this.isHidden = false,
    this.completedCount = 0,
    required this.onHidePressed,
    required this.systemBarHeight,
    required this.bigTitleStyle,
    required this.smallTitleStyle,
    required this.context,
  })  : bigTitleHeight = bigTitleStyle.fontSize! * bigTitleStyle.height!,
        smallTitleHeight = smallTitleStyle.fontSize! * smallTitleStyle.height!;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    final flexibleSpace = bigTitleOffset + bigTitleHeight + 44;
    final k = shrinkOffset >= flexibleSpace
        ? 0.0
        : (flexibleSpace - shrinkOffset) / flexibleSpace;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(lerpDouble(20, 0, k)!.toInt(), 0, 0, 0),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: lerpDouble(16, 60, k)!,
          ),
          child: Column(
            children: [
              SizedBox(
                height: systemBarHeight + k * bigTitleOffset + 18,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: smallTitleHeight + bigTitleHeight * k + 4,
                  child: Text(
                    shrinkOffset > 0 ? 'Мои дела' : 'Мои дела',
                    style: TextStyle.lerp(smallTitleStyle, bigTitleStyle, k),
                  ),
                ),
              ),
              if (shrinkOffset > 30)
                const SizedBox.shrink()
              else
                Column(
                  children: [
                    const SizedBox(height: 6),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Выполнено - $completedCount')),
                  ],
                ),
            ],
          ),
        ),
        Positioned(
          bottom: lerpDouble(14, 30, k)!,
          right: 16,
          child: isHidden
              ? AppIcons.visibilityOff(
                  color: themeColors.blue,
                )
              : AppIcons.visibility(
                  color: themeColors.blue,
                ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
