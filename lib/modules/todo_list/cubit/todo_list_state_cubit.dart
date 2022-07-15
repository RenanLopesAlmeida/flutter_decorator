import 'package:decorator_pattern_flutter/modules/todo_list/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/cubit/todo_list_state.dart';

class TodoListStateCubit extends Cubit<TodoListState> {
  TodoListStateCubit() : super(const TodoListEmptyState());

  void todosLoading() {
    emit(const TodoListLoadingState());
  }

  void todosLoaded(List<Todo> todos) {
    emit(TodoListLoadedState(todos));
  }

  void todosError(String error) {
    emit(TodoListErrorState(error));
  }

  void todosCleared() {
    emit(const TodoListEmptyState());
  }
}
