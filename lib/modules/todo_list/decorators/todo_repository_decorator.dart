import 'package:decorator_pattern_flutter/modules/todo_list/models/todo.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/repositories/todo_repository.dart';

class TodoRepositoryDecorator {
  TodoRepositoryDecorator(this._todoRepository);
  final TodoRepository _todoRepository;

  Future<List<Todo>> getTodos() async {
    return await _todoRepository.getTodos();
  }
}
