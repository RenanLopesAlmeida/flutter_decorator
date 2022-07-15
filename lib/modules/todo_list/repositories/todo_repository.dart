import 'dart:convert';

import 'package:decorator_pattern_flutter/modules/todo_list/entities/todo_entity.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/models/todo.dart';
import 'package:http/http.dart' as http;

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<void> createTodo(String title);
  Future<void> updateTodo(int id, String title);
  Future<void> deleteTodo(int id);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({
    required final HttpClient client,
  }) : _httpClient = client;

  final HttpClient _httpClient;

  @override
  Future<List<Todo>> getTodos() async {
    final response = await _httpClient.request(
      'https://jsonplaceholder.typicode.com/todos',
    );

    if (response.statusCode == 200) {
      final List<Todo> todos = [];

      (jsonDecode(response.body) as List).map((todo) {
        final todoEntity = TodoEntity.fromJson(todo);
        todos.add(Todo.fromEntity(todoEntity));
      }).toList();
      return todos;
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<void> createTodo(String title) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(int id, String title) {
    throw UnimplementedError();
  }
}

abstract class HttpClient {
  Future<http.Response> request(String url);
}

class RemoteHttpClient implements HttpClient {
  @override
  Future<http.Response> request(String url) async {
    final uri = Uri.parse(url);
    final result = await http.get(uri);

    return result;
  }
}
