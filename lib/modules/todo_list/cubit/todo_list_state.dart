import 'package:decorator_pattern_flutter/modules/todo_list/models/todo.dart';

abstract class TodoListState {
  const TodoListState();
}

class TodoListEmptyState extends TodoListState {
  const TodoListEmptyState();
}

class TodoListLoadingState extends TodoListState {
  const TodoListLoadingState();
}

class TodoListLoadedState extends TodoListState {
  final List<Todo> todos;

  const TodoListLoadedState(this.todos);
}

class TodoListErrorState extends TodoListState {
  final String error;

  const TodoListErrorState(this.error);
}
