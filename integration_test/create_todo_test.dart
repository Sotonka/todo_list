import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_flutter_task/app.dart';
import 'package:yandex_flutter_task/core/enums.dart';
import 'package:yandex_flutter_task/data/datasource/local_datasource/local_datasource.dart';
import 'package:yandex_flutter_task/data/datasource/remote_datasource/remote_datasource.dart';
import 'package:yandex_flutter_task/data/repository/provider.dart';
import 'package:yandex_flutter_task/data/repository/todos_repository_impl.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/add_button.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/todo_list.dart';
import 'package:yandex_flutter_task/presentation/widgets/main_screen_widgets/todo_tile.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/body_form.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/deadline_form.dart';
import 'package:yandex_flutter_task/presentation/widgets/todo_screen_widgets/importance_form.dart';
import 'package:integration_test/integration_test.dart';

import '../test/mocks/local_datasource.mocks.dart';
import '../test/mocks/remote_datasource.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late Todo todo;
  late RemoteDataSource remoteDataSource;
  late LocalDataSource localDataSource;

  Future<void> getApp() async {
    runZonedGuarded(
      () {
        runApp(
          ProviderScope(
            overrides: [
              todosRepositoryProvider.overrideWith(
                (ref) {
                  return TodosRepositoryImpl(
                    localDataSource,
                    remoteDataSource,
                  );
                },
              ),
            ],
            child: const App(
              flavour: Flavour.dev,
            ),
          ),
        );
      },
      (_, __) {},
    );
  }

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    localDataSource = MockLocalDataSource();
    final id = const Uuid().v4().toString();
    final date = DateTime.now();
    todo = Todo(
      id: id,
      text: 'test$id',
      created_at: date.millisecondsSinceEpoch,
      changed_at: date.millisecondsSinceEpoch,
      last_updated_by: 'device_id',
      importance: 'low',
      deadline: date.millisecondsSinceEpoch,
      done: false,
    );
    const revision = 0;

    when(remoteDataSource.createTodo(any, 0)).thenAnswer((_) async {
      return todo;
    });
    when(localDataSource.saveTodo(any)).thenAnswer((_) async => todo);

    when(remoteDataSource.getTodos()).thenAnswer(
      (_) async => const TodoList(
        revision: revision,
        status: 'ok',
        list: [],
      ),
    );
    when(localDataSource.getTodos()).thenAnswer(
      (_) async => const TodoList(
        revision: revision,
        status: 'ok',
        list: [],
      ),
    );

    when(localDataSource.getRevision()).thenAnswer(
      (_) async => revision,
    );
  });

  group(
    'create todo test',
    () {
      testWidgets(
        'tap on add button, create todo, check todo on home page',
        (tester) async {
          await getApp();

          final Finder targetFinder = find.byWidgetPredicate(
              (widget) => widget is TodoTile && widget.todo.text == todo.text);

          await tester.pumpAndSettle();
          expect(find.byType(TodoListWidget), findsOneWidget);
          expect(targetFinder, findsNothing);

          await tester.tap(find.byType(AddTodoButtonWidget));
          await tester.pumpAndSettle();

          expect(find.byType(BodyFormWidget), findsOneWidget);
          expect(find.byType(ImportanceFormWidget), findsOneWidget);
          expect(find.byType(DeadlineFormWidget), findsOneWidget);

          await tester.enterText(
            find.byType(TextFormField),
            todo.text,
          );
          await tester.pumpAndSettle();
          expect(find.text(todo.text), findsOneWidget);

          await tester.tap(
            find.text('Нет', findRichText: true),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.text('Низкий', findRichText: true));
          await tester.pumpAndSettle();
          expect(find.text('Низкий', findRichText: true), findsOneWidget);

          await tester.tap(find.byType(Switch));
          await tester.pumpAndSettle();
          await tester.tap(find.widgetWithText(TextButton, 'ГОТОВО'));
          await tester.pumpAndSettle();
          expect(find.text(DateFormat.yMMMMd().format(DateTime.now())),
              findsNothing);

          await tester.tap(find.byKey(const ValueKey('save')));
          await tester.pumpAndSettle();
          await tester.pump(const Duration(seconds: 3));
          await tester.pumpAndSettle();

          await tester.dragUntilVisible(
            targetFinder,
            find.byType(TodoListWidget),
            const Offset(-3000, 0),
          );
          await tester.pump(const Duration(seconds: 1));

          expect(targetFinder, findsOneWidget);
        },
      );
    },
  );
}
