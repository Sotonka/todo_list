import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StreamController<String> _todoUpdateStreamController =
        StreamController.broadcast();
    // Stream<Todo> get todoUpdateStream => _todoUpdateStreamController.stream;

    final StreamController<int> _todoDeleteStreamController =
        StreamController.broadcast();
    // Stream<int> get todoDeleteStream => _todoDeleteStreamController.stream;

    /* void dispose() {
    _todoUpdateStreamController.close();
    _todoDeleteStreamController.close();
  } */

    late final StreamSubscription<String> _todoUpdateSubsciption;
    late final StreamSubscription<int> _todoDeleteSubsciption;

    _todoUpdateSubsciption =
        _todoUpdateStreamController.stream.listen((string) {
      addLine(string);
    });

    _todoDeleteSubsciption =
        _todoDeleteStreamController.stream.listen((todoId) {});

    return Scaffold(
      body: Column(
        children: [],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          print('added');
          _todoUpdateStreamController.add('1');
        },
        child: Container(
          height: 100,
          width: 100,
          color: Colors.pink,
        ),
      ),
    );
  }
}

Future<void> addLine(String string) async {
  await Future.delayed(const Duration(seconds: 3));
  print('~~~FUTURE $string~~~');
}
