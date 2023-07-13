// Mocks generated by Mockito 5.4.2 from annotations
// in yandex_flutter_task/test/mocks/local_datasource.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:yandex_flutter_task/data/datasource/local_datasource/local_datasource.dart'
    as _i4;
import 'package:yandex_flutter_task/domain/model/todo.dart' as _i3;
import 'package:yandex_flutter_task/domain/model/todo_list.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTodoList_0 extends _i1.SmartFake implements _i2.TodoList {
  _FakeTodoList_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTodo_1 extends _i1.SmartFake implements _i3.Todo {
  _FakeTodo_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock implements _i4.LocalDataSource {
  MockLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.TodoList> getTodos() => (super.noSuchMethod(
        Invocation.method(
          #getTodos,
          [],
        ),
        returnValue: _i5.Future<_i2.TodoList>.value(_FakeTodoList_0(
          this,
          Invocation.method(
            #getTodos,
            [],
          ),
        )),
      ) as _i5.Future<_i2.TodoList>);
  @override
  _i5.Future<void> saveTodo(_i3.Todo? todo) => (super.noSuchMethod(
        Invocation.method(
          #saveTodo,
          [todo],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> updateTodo(_i3.Todo? todo) => (super.noSuchMethod(
        Invocation.method(
          #updateTodo,
          [todo],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<_i3.Todo> deleteTodo(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteTodo,
          [id],
        ),
        returnValue: _i5.Future<_i3.Todo>.value(_FakeTodo_1(
          this,
          Invocation.method(
            #deleteTodo,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Todo>);
  @override
  _i5.Future<void> todosToCache(_i2.TodoList? todos) => (super.noSuchMethod(
        Invocation.method(
          #todosToCache,
          [todos],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<int> getRevision() => (super.noSuchMethod(
        Invocation.method(
          #getRevision,
          [],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<void> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}