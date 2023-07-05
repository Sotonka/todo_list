typedef JsonMap = Map<String, dynamic>;

abstract mixin class TypedSegment {
  factory TypedSegment.fromJson(JsonMap json) {
    if (json['path'] == 'EditTodoSegment') {
      return EditTodoSegment(id: json['id']);
    }
    if (json['path'] == 'CreateTodoSegment') {
      return CreateTodoSegment();
    }
    if (json['path'] == 'TodoListSegment') {
      return TodoListSegment();
    }
    return TodoListSegment();
  }

  factory TypedSegment.fromString(String s) {
    if (s.contains('edit')) {
      final id = s.split('edit')[1];
      return EditTodoSegment(id: id);
    }
    if (s == 'create') {
      return CreateTodoSegment();
    }
    if (s == 'list') {
      return TodoListSegment();
    }
    return TodoListSegment();
  }

  JsonMap toJson() => <String, dynamic>{'path': runtimeType.toString()};

  @override
  String toString() {
    if (toJson()['path'] == 'EditTodoSegment' && toJson()['id'] != null) {
      return 'edit${toJson()['id']}';
    }

    if (toJson()['path'] == 'CreateTodoSegment') {
      return 'create';
    }
    if (toJson()['path'] == 'TodoListSegment') {
      return 'list';
    }

    return 'list';
  }
}

typedef TypedPath = List<TypedSegment>;

class TodoListSegment with TypedSegment {}

class CreateTodoSegment with TypedSegment {}

class EditTodoSegment with TypedSegment {
  EditTodoSegment({required this.id});

  final String id;

  @override
  JsonMap toJson() => super.toJson()..['id'] = id;
}
