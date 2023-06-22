import 'package:flutter/material.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(
          color: themeColors.blue,
        ),
      ),
    );
  }
}
