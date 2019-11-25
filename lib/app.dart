import 'package:flutter/material.dart';
import 'package:flutter_arch_todo_vanilla/core/keys.dart';
import 'package:flutter_arch_todo_vanilla/core/localization/app_localizations.dart';
import 'package:flutter_arch_todo_vanilla/core/routes.dart';
import 'package:flutter_arch_todo_vanilla/core/theme.dart';
import 'package:flutter_arch_todo_vanilla/screens/add_edit_screen.dart';
import 'package:flutter_arch_todo_vanilla/screens/home_screen.dart';

import 'data/app_state.dart';
import 'data/todo_repository.dart';

class TodoApp extends StatefulWidget {
  final TodosRepository repository;

  TodoApp({@required this.repository});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {

  AppState appState = AppState.loading();

  @override
  void initState() {
    super.initState();

    widget.repository.loadTodos().then((loadedTodos) {
      setState(() {
        appState = AppState(
          todos: loadedTodos.map(Todo.fromEntity).toList(),
        );
      });
    }).catchError((err) {
      setState(() {
        appState.isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TodoTheme.theme,
      localizationsDelegates: [
        TodoLocalizationsDelegate(),
      ],
      title: TodoLocalizations.appTitle,
      routes: {
        TodoRoutes.home: (context) {
          return HomeScreen(
            appState: appState,
            updateTodo: updateTodo,
            addTodo: addTodo,
            removeTodo: removeTodo,
            toggleAll: toggleAll,
            clearCompleted: clearCompleted,
          );
        },
        TodoRoutes.addTodo: (context) {
          return AddEditScreen(
            key: TodoKeys.addTodoScreen,
            addTodo: addTodo,
            updateTodo: updateTodo,
          );
        },
      },
    );
  }

  void toggleAll() {
    setState(() {
      appState.toggleAll();
    });
  }

  void clearCompleted() {
    setState(() {
      appState.clearCompleted();
    });
  }

  void addTodo(Todo todo) {
    setState(() {
      appState.todos.add(todo);
    });
  }

  void removeTodo(Todo todo) {
    setState(() {
      appState.todos.remove(todo);
    });
  }

  void updateTodo(
      Todo todo, {
        bool complete,
        String id,
        String note,
        String task,
      }) {
    setState(() {
      todo.complete = complete ?? todo.complete;
      todo.id = id ?? todo.id;
      todo.note = note ?? todo.note;
      todo.task = task ?? todo.task;
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    widget.repository.saveTodos(
      appState.todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
