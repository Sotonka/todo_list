import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/todo_list_provider.dart';
import 'package:yandex_flutter_task/presentation/ui_kit/ui_kit.dart';

class ErrorMessageWidget extends ConsumerWidget {
  final String message;
  const ErrorMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeColors = theme.extension<AppThemeColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Icon(
            Icons.error,
            size: 50,
            color: themeColors.red,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: theme.primaryTextTheme.bodyMedium!.copyWith(
              color: themeColors.red,
            ),
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: () {
              ref.read(todoListProvider.notifier).getTodos();
            },
            child: Container(
              decoration: BoxDecoration(
                color: themeColors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.refresh,
                size: 50,
                color: themeColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
