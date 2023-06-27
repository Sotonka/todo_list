import 'package:flutter_test/flutter_test.dart';
import 'package:yandex_flutter_task/domain/model/todo.dart';
import 'package:yandex_flutter_task/domain/model/todo_list.dart';

void main() {
  group(
    'methods',
    () {
      group(
        'addTodo',
        () {
          test(
            'should return todoList with updated revision',
            () {
              TodoList actual = const TodoList(
                list: [],
                revision: 0,
                status: 'ok',
              );
              actual = actual
                  .addTodo(_buildTodo('0'))
                  .addTodo(_buildTodo('1'))
                  .addTodo(_buildTodo('2'));

              final expected = TodoList(
                list: [
                  _buildTodo('0'),
                  _buildTodo('1'),
                  _buildTodo('2'),
                ],
                revision: 3,
                status: 'ok',
              );
              expect(actual, expected);
            },
          );
        },
      );

      group(
        'getTodo',
        () {
          test(
            'should return todo list of todos with id',
            () {
              final actual = TodoList(
                list: [
                  _buildTodo('0'),
                  _buildTodo('0'),
                  _buildTodo('1'),
                  _buildTodo('0'),
                  _buildTodo('2'),
                ],
                revision: 0,
                status: 'ok',
              ).getTodo('0');

              final expected = TodoList(
                list: [
                  _buildTodo('0'),
                  _buildTodo('0'),
                  _buildTodo('0'),
                ],
                revision: 0,
                status: 'ok',
              );
              expect(actual, expected);
            },
          );

          test(
            'should return empty todo list',
            () {
              final actual = TodoList(
                list: [
                  _buildTodo('0'),
                  _buildTodo('1'),
                ],
                revision: 0,
                status: 'ok',
              ).getTodo('2');

              const expected = TodoList(
                list: [],
                revision: 0,
                status: 'ok',
              );
              expect(actual, expected);
            },
          );
        },
      );

      group(
        'updateTodo',
        () {
          test(
            'should return todoList with updated revision',
            () {
              TodoList actual = TodoList(
                list: [
                  _buildTodo('0'),
                  _buildTodo('1'),
                  _buildTodo('2'),
                ],
                revision: 0,
                status: 'ok',
              );
              actual = actual
                  .updateTodo(_buildTodo('0').copyWith(text: 'upd1'))
                  .updateTodo(_buildTodo('1').copyWith(text: 'upd2'))
                  .updateTodo(_buildTodo('2').copyWith(text: 'upd3'));

              final expected = TodoList(
                list: [
                  _buildTodo('0').copyWith(text: 'upd1'),
                  _buildTodo('1').copyWith(text: 'upd2'),
                  _buildTodo('2').copyWith(text: 'upd3'),
                ],
                revision: 3,
                status: 'ok',
              );
              expect(actual, expected);
            },
          );
        },
      );

      group(
        'deleteTodo',
        () {
          test(
            'should return todoList with updated revision',
            () {
              TodoList actual = TodoList(
                list: [
                  _buildTodo('0'),
                  _buildTodo('1'),
                  _buildTodo('2'),
                ],
                revision: 0,
                status: 'ok',
              );
              actual = actual.deleteTodo('0').deleteTodo('2');

              final expected = TodoList(
                list: [
                  _buildTodo('1'),
                ],
                revision: 2,
                status: 'ok',
              );
              expect(actual, expected);
            },
          );
        },
      );

      group(
        'filterByCompleted',
        () {
          test(
            'should return todoList of todos with done = true',
            () {
              TodoList actual = TodoList(
                list: [
                  _buildTodo('0').copyWith(done: false),
                  _buildTodo('1').copyWith(done: true),
                  _buildTodo('2').copyWith(done: false),
                  _buildTodo('3').copyWith(done: true),
                  _buildTodo('4').copyWith(done: false),
                ],
                revision: 0,
                status: 'ok',
              );
              actual = actual.filterByCompleted();

              final expected = TodoList(
                list: [
                  _buildTodo('1').copyWith(done: true),
                  _buildTodo('3').copyWith(done: true),
                ],
                revision: 0,
                status: 'ok',
              );
              expect(actual, expected);
            },
          );
        },
      );
    },
  );
  group(
    '[] operator',
    () {
      group(
        'when index value is valid',
        () {
          test(
            'should return todo',
            () {
              final actual = TodoList(
                list: [
                  _buildTodo('0'),
                  _buildTodo('1'),
                  _buildTodo('2'),
                  _buildTodo('3'),
                ],
                revision: 0,
                status: 'ok',
              )[2];
              final expected = _buildTodo('2');
              expect(actual, expected);
            },
          );
        },
      );

      group(
        'index value is invalid',
        () {
          test(
            'should throw exception',
            () {
              final todoList = TodoList(
                list: [
                  _buildTodo('0'),
                  _buildTodo('1'),
                  _buildTodo('2'),
                  _buildTodo('3'),
                ],
                revision: 0,
                status: 'ok',
              );
              expect(() => todoList[4], throwsRangeError);
            },
          );
        },
      );
    },
  );

  group(
    'length getter',
    () {
      group(
        'todo list is empty',
        () {
          test(
            'should return 0',
            () {
              final actual =
                  const TodoList(list: [], status: 'ok', revision: 890).length;
              expect(actual, 0);
            },
          );
        },
      );

      group(
        'todo list is not empty',
        () {
          test(
            'should return 2',
            () {
              final actual = TodoList(
                list: [
                  _buildTodo('1'),
                  _buildTodo('2'),
                ],
                status: 'ok',
                revision: 0,
              ).length;
              expect(actual, 2);
            },
          );
        },
      );
    },
  );
}

Todo _buildTodo(final String id) {
  return Todo(
    id: id,
    last_updated_by: 'lastUpdatedBy$id',
    created_at: DateTime.parse('2023-06-01').millisecondsSinceEpoch,
    changed_at: DateTime.parse('2023-06-01').millisecondsSinceEpoch,
    deadline: DateTime.parse('2023-06-01').millisecondsSinceEpoch,
    text: 'text$id',
    done: false,
    importance: 'importance$id',
  );
}
