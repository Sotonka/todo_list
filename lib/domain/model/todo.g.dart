// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: json['importance'] as String? ?? 'basic',
      deadline: json['deadline'] as int?,
      done: json['done'] as bool? ?? false,
      color: json['color'] as String? ?? '#FFFFFF',
      created_at: json['created_at'] as int,
      changed_at: json['changed_at'] as int,
      last_updated_by: json['last_updated_by'] as String,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': instance.importance,
      'deadline': instance.deadline,
      'done': instance.done,
      'color': instance.color,
      'created_at': instance.created_at,
      'changed_at': instance.changed_at,
      'last_updated_by': instance.last_updated_by,
    };
