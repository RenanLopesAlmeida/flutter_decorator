import 'package:decorator_pattern_flutter/modules/todo_list/cubit/todo_list_state_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:decorator_pattern_flutter/modules/todo_list/decorators/todo_repository_cache_decorator.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/models/todo.dart';

class TodoListCubit extends Cubit<List<Todo>> {
  TodoListCubit({
    required final TodoRepositoryCacheDecorator todoRepositoryCacheDecorator,
  })  : _todoRepositoryCacheDecorator = todoRepositoryCacheDecorator,
        super([]);

  final TodoRepositoryCacheDecorator _todoRepositoryCacheDecorator;

  Future<void> getTodos(final BuildContext context) async {
    context.read<TodoListStateCubit>().todosLoading();

    final todos = await _todoRepositoryCacheDecorator.getTodos();
    //await Future.delayed(const Duration(seconds: 3));
    emit(todos);

    context.read<TodoListStateCubit>().todosLoaded(todos);
  }
}
