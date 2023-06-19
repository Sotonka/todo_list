import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    return Divider(color: themeColors.supportSeparator);
  }
}
