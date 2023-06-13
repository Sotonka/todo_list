import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/app.dart';

void main() async {
  runApp(const ProviderScope(child: App()));
}
