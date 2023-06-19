// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return _Todo.fromJson(json);
}

/// @nodoc
mixin _$Todo {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get importance => throw _privateConstructorUsedError;
  int? get deadline => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int get created_at => throw _privateConstructorUsedError;
  int get changed_at => throw _privateConstructorUsedError;
  String get last_updated_by => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoCopyWith<Todo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) =
      _$TodoCopyWithImpl<$Res, Todo>;
  @useResult
  $Res call(
      {String id,
      String text,
      String importance,
      int? deadline,
      bool done,
      String? color,
      int created_at,
      int changed_at,
      String last_updated_by});
}

/// @nodoc
class _$TodoCopyWithImpl<$Res, $Val extends Todo>
    implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? importance = null,
    Object? deadline = freezed,
    Object? done = null,
    Object? color = freezed,
    Object? created_at = null,
    Object? changed_at = null,
    Object? last_updated_by = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int,
      changed_at: null == changed_at
          ? _value.changed_at
          : changed_at // ignore: cast_nullable_to_non_nullable
              as int,
      last_updated_by: null == last_updated_by
          ? _value.last_updated_by
          : last_updated_by // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TodoCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$$_TodoCopyWith(_$_Todo value, $Res Function(_$_Todo) then) =
      __$$_TodoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      String importance,
      int? deadline,
      bool done,
      String? color,
      int created_at,
      int changed_at,
      String last_updated_by});
}

/// @nodoc
class __$$_TodoCopyWithImpl<$Res> extends _$TodoCopyWithImpl<$Res, _$_Todo>
    implements _$$_TodoCopyWith<$Res> {
  __$$_TodoCopyWithImpl(_$_Todo _value, $Res Function(_$_Todo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? importance = null,
    Object? deadline = freezed,
    Object? done = null,
    Object? color = freezed,
    Object? created_at = null,
    Object? changed_at = null,
    Object? last_updated_by = null,
  }) {
    return _then(_$_Todo(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as int?,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int,
      changed_at: null == changed_at
          ? _value.changed_at
          : changed_at // ignore: cast_nullable_to_non_nullable
              as int,
      last_updated_by: null == last_updated_by
          ? _value.last_updated_by
          : last_updated_by // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Todo extends _Todo {
  const _$_Todo(
      {required this.id,
      required this.text,
      this.importance = 'basic',
      this.deadline,
      this.done = false,
      this.color = '#FFFFFF',
      required this.created_at,
      required this.changed_at,
      required this.last_updated_by})
      : super._();

  factory _$_Todo.fromJson(Map<String, dynamic> json) => _$$_TodoFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  @JsonKey()
  final String importance;
  @override
  final int? deadline;
  @override
  @JsonKey()
  final bool done;
  @override
  @JsonKey()
  final String? color;
  @override
  final int created_at;
  @override
  final int changed_at;
  @override
  final String last_updated_by;

  @override
  String toString() {
    return 'Todo(id: $id, text: $text, importance: $importance, deadline: $deadline, done: $done, color: $color, created_at: $created_at, changed_at: $changed_at, last_updated_by: $last_updated_by)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Todo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.changed_at, changed_at) ||
                other.changed_at == changed_at) &&
            (identical(other.last_updated_by, last_updated_by) ||
                other.last_updated_by == last_updated_by));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, importance, deadline,
      done, color, created_at, changed_at, last_updated_by);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoCopyWith<_$_Todo> get copyWith =>
      __$$_TodoCopyWithImpl<_$_Todo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoToJson(
      this,
    );
  }
}

abstract class _Todo extends Todo {
  const factory _Todo(
      {required final String id,
      required final String text,
      final String importance,
      final int? deadline,
      final bool done,
      final String? color,
      required final int created_at,
      required final int changed_at,
      required final String last_updated_by}) = _$_Todo;
  const _Todo._() : super._();

  factory _Todo.fromJson(Map<String, dynamic> json) = _$_Todo.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get importance;
  @override
  int? get deadline;
  @override
  bool get done;
  @override
  String? get color;
  @override
  int get created_at;
  @override
  int get changed_at;
  @override
  String get last_updated_by;
  @override
  @JsonKey(ignore: true)
  _$$_TodoCopyWith<_$_Todo> get copyWith => throw _privateConstructorUsedError;
}
