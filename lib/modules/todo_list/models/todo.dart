import 'package:decorator_pattern_flutter/modules/todo_list/entities/todo_entity.dart';

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  final int id;
  final String title;
  final bool completed;

  factory Todo.fromEntity(TodoEntity entity) {
    return Todo(
      id: entity.id,
      title: entity.title,
      completed: entity.completed,
    );
  }

  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      completed: completed,
    );
  }
}
