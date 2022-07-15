import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/adapters/shared_preferences_adapter.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/cubit/todo_list_cubit.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/cubit/todo_list_state_cubit.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/decorators/todo_repository_cache_decorator.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/repositories/todo_repository.dart';
import 'package:decorator_pattern_flutter/modules/todo_list/ui/todo_list/todo_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TodoListCubit>(
            create: (context) => TodoListCubit(
              todoRepositoryCacheDecorator: TodoRepositoryCacheDecorator(
                todoRepository: TodoRepositoryImpl(
                  client: RemoteHttpClient(),
                ),
                localStorageAdapter: SharedPreferencesAdapter(),
              ),
            ),
            child: const TodoListScreen(),
          ),
          BlocProvider<TodoListStateCubit>(
            create: (context) => TodoListStateCubit(),
            child: const TodoListScreen(),
          ),
        ],
        child: const TodoListScreen(),
      ),
    );
  }
}
