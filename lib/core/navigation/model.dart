import 'package:yandex_flutter_task/domain/model/todo.dart';

typedef JsonMap = Map<String, dynamic>;

abstract mixin class TypedSegment {
  factory TypedSegment.fromJson(JsonMap json) {
    if (json['path'] == 'EditTodoSegment') {
      return EditTodoSegment(todo: json['todo']);
    }
    if (json['path'] == 'CreateTodoSegment') {
      return CreateTodoSegment();
    }
    if (json['path'] == 'TodoListSegment') {
      return TodoListSegment();
    }
    return TodoListSegment();
  }

  JsonMap toJson() => <String, dynamic>{'path': runtimeType.toString()};

  @override
  String toString() {
    if (toJson()['path'] == 'EditTodoSegment' && toJson()['todo'] != null) {
      return toJson()['path'] + toJson()['todo'];
    }

    return toJson()['path'];
  }
}

typedef TypedPath = List<TypedSegment>;

class TodoListSegment with TypedSegment {}

class CreateTodoSegment with TypedSegment {}

class EditTodoSegment with TypedSegment {
  EditTodoSegment({required this.todo});

  final Todo todo;

  @override
  JsonMap toJson() => super.toJson()..['todo'] = todo.id;
}
