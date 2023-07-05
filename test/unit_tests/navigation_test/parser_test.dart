import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yandex_flutter_task/core/navigation/model.dart';
import 'package:yandex_flutter_task/core/navigation/parser.dart';

void main() {
  group(
    'parseRouteInformation',
    () {
      final parser = RouteInformationParserImpl();
      test(
        'should return TypedSegment of exact type',
        () async {
          final actualList = await parser.parseRouteInformation(
            const RouteInformation(location: '/list/create'),
          );
          final expected = [
            TodoListSegment().runtimeType,
            CreateTodoSegment().runtimeType
          ];
          final actual = [];

          for (var i in actualList) {
            actual.add(i.runtimeType);
          }

          expect(actual, expected);
        },
      );
    },
  );

  group(
    'restoreRouteInformation',
    () {
      test(
        'should convert typed path (list of TypedSegment) to string',
        () {
          final parser = RouteInformationParserImpl();

          final actualRouteInformation = parser.restoreRouteInformation([
            TodoListSegment(),
            CreateTodoSegment(),
          ]);

          final expected = [
            {'path': 'TodoListSegment'},
            {'path': 'CreateTodoSegment'},
          ];

          final actual = [];

          for (final s in actualRouteInformation.location!.split('/')) {
            actual.add(jsonDecode(Uri.decodeComponent(s)));
          }

          expect(actual, expected);
        },
      );
    },
  );
}
