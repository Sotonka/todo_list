import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/presentation/providers/test_provider.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text(ref.watch(TestNotifierProvider).counter.toString()),
              Text(ref.watch(TestStateNotifierProvider).toString()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(TestNotifierProvider).increment();
          ref.read(TestStateNotifierProvider.notifier).increment();
        },
      ),
    );
  }
}
