import 'package:decorator_pattern_flutter/modules/todo_list/cubit/todo_list_cubit.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/cubit/todo_list_state.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/cubit/todo_list_state_cubit.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocBuilder<TodoListStateCubit, TodoListState>(
        builder: (context, state) {
          if (state is TodoListEmptyState) {
            _loadTodos(context);
            return const Center(
              child: Text('No todos'),
            );
          } else if (state is TodoListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoListLoadedState) {
            return _TodoList(todos: state.todos);
          } else if (state is TodoListErrorState) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }

  Future<void> _loadTodos(final BuildContext context) async {
    await context.read<TodoListCubit>().getTodos(context);
  }
}

class _TodoList extends StatelessWidget {
  const _TodoList({
    required List<Todo> todos,
    Key? key,
  })  : _todos = todos,
        super(key: key);

  final List<Todo> _todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        final todo = _todos[index];
        return ListTile(
          leading: Text(todo.id.toString()),
          title: Text(todo.title),
          subtitle: Text(todo.title),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
