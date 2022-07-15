import 'dart:convert';

import 'package:decorator_pattern_flutter/modules/todo_list/decorators/todo_repository_decorator.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/entities/todo_entity.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/models/todo.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/repositories/todo_repository.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/adapters/local_storage_adapter.dart';

class TodoRepositoryCacheDecorator extends TodoRepositoryDecorator {
  TodoRepositoryCacheDecorator({
    required final TodoRepository todoRepository,
    required final LocalStorageAdapter localStorageAdapter,
  })  : _localStorageAdapter = localStorageAdapter,
        super(todoRepository);

  final LocalStorageAdapter _localStorageAdapter;

  @override
  Future<List<Todo>> getTodos() async {
    try {
      final todos = await super.getTodos();
      _saveCache(todos);
      return todos;
    } catch (e) {
      return await _getCache();
    }
  }

  Future<void> _saveCache(List<Todo> todos) async {
    final jsonData = todos
        .map(
          (todo) => jsonEncode(todo.toEntity()),
        )
        .toList();

    await _localStorageAdapter.saveData<Todo>(
      data: jsonData,
      key: 'todos',
    );
  }

  Future<List<Todo>> _getCache() async {
    final cachedData = await _localStorageAdapter.getData('todos');

    final todos = cachedData.map((data) {
      final json = jsonEncode(data) as Map<String, dynamic>;
      final todoEntity = TodoEntity.fromJson(json);

      return Todo.fromEntity(todoEntity);
    }).toList();

    return todos;
  }
}
