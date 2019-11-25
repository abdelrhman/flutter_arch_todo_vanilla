// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_todo_vanilla/core/keys.dart';
import 'package:flutter_arch_todo_vanilla/core/localization/app_localizations.dart';
import 'package:flutter_arch_todo_vanilla/data/app_state.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/todo_item.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/typedefs.dart';

import '../details_screen.dart';

class TodoList extends StatelessWidget {
  final List<Todo> filteredTodos;
  final bool loading;
  final TodoAdder addTodo;
  final TodoRemover removeTodo;
  final TodoUpdater updateTodo;

  TodoList({
    @required this.filteredTodos,
    @required this.loading,
    @required this.addTodo,
    @required this.removeTodo,
    @required this.updateTodo,
  }) : super(key: TodoKeys.todoList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? Center(
              child: CircularProgressIndicator(
              key: TodoKeys.todosLoading,
            ))
          : ListView.builder(
              key: TodoKeys.todoList,
              itemCount: filteredTodos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = filteredTodos[index];

                return TodoItem(
                  todo: todo,
                  onDismissed: (direction) {
                    _removeTodo(context, todo);
                  },
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return DetailScreen(
                            todo: todo,
                            onDelete: () => _removeTodo(context, todo),
                            addTodo: addTodo,
                            updateTodo: updateTodo,
                          );
                        },
                      ),
                    );
                  },
                  onCheckboxChanged: (complete) {
                    updateTodo(todo, complete: !todo.complete);
                  },
                );
              },
            ),
    );
  }

  void _removeTodo(BuildContext context, Todo todo) {
    removeTodo(todo);

    Scaffold.of(context).showSnackBar(
          SnackBar(
            key: TodoKeys.snackbar,
            duration: Duration(seconds: 2),
            backgroundColor: Theme.of(context).backgroundColor,
            content: Text(
              TodoLocalizations.of(context).todoDeleted(todo.task),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: TodoLocalizations.of(context).undo,
              onPressed: () {
                addTodo(todo);
              },
            ),
          ),
        );
  }
}
