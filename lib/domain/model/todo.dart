// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String text,
    @Default('basic') String importance,
    int? deadline,
    @Default(false) bool done,
    @Default('#FFFFFF') String? color,
    required int created_at,
    required int changed_at,
    required String last_updated_by,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);

  const Todo._();
}
