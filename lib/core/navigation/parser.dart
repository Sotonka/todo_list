import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:yandex_flutter_task/core/logger/logger.dart';
import 'package:yandex_flutter_task/core/navigation/model.dart';

class RouteInformationParserImpl implements RouteInformationParser<TypedPath> {
  @override
  Future<TypedPath> parseRouteInformation(RouteInformation routeInformation) =>
      Future.value(pathToTypedPath(routeInformation.location));

  @override
  RouteInformation restoreRouteInformation(TypedPath configuration) =>
      RouteInformation(location: typedPathToPath(configuration));

  static String typedPathToPath(TypedPath typedPath) {
    logger.wtf(
      typedPath.map((s) => s.toString()).join('/'),
    );

    return typedPath
        .map((s) => Uri.encodeComponent(jsonEncode(s.toJson())))
        .join('/');
  }

  static TypedPath pathToTypedPath(String? path) {
    logger.wtf(path);
    if (path == null || path.isEmpty) return [];
    logger.wtf([
      for (final s in path.split('/'))
        if (s.isNotEmpty) TypedSegment.fromJson(jsonDecode(Uri.decodeFull(s)))
    ]);
    return [
      for (final s in path.split('/'))
        if (s.isNotEmpty) TypedSegment.fromJson(jsonDecode(Uri.decodeFull(s)))
    ];
  }

  @override
  Future<TypedPath> parseRouteInformationWithDependencies(
          RouteInformation routeInformation, BuildContext context) =>
      parseRouteInformation(routeInformation);
}
