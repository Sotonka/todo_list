import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_flutter_task/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: App()));
}

// TODO
// http://todos.com/{"path":"TodoListSegment"}/{"path":"CreateTodoSegment"}

//{"path":"TodoListSegment"}/{"path":"CreateTodoSegment"}
// из-за особенностей перехода на edit todo страницу, через диплинк не получится перейти, будет восприниматься как create
// 
