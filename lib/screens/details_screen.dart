// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_todo_vanilla/core/keys.dart';
import 'package:flutter_arch_todo_vanilla/core/localization/app_localizations.dart';
import 'package:flutter_arch_todo_vanilla/data/app_state.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/typedefs.dart';

import 'add_edit_screen.dart';

class DetailScreen extends StatelessWidget {
  final Todo todo;
  final Function onDelete;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;

  DetailScreen({
    @required this.todo,
    @required this.addTodo,
    @required this.updateTodo,
    @required this.onDelete,
  }) : super(key: TodoKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TodoLocalizations.of(context).todoDetails),
        actions: [
          IconButton(
            key: TodoKeys.deleteTodoButton,
            tooltip: TodoLocalizations.of(context).deleteTodo,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context, todo);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: todo.complete,
                    key: TodoKeys.detailsTodoItemCheckbox,
                    onChanged: (complete) {
                      updateTodo(todo, complete: !todo.complete);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          todo.task,
                          key: TodoKeys.detailsTodoItemTask,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      Text(
                        todo.note,
                        key: TodoKeys.detailsTodoItemNote,
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: TodoLocalizations.of(context).editTodo,
        child: Icon(Icons.edit),
        key: TodoKeys.editTodoFab,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddEditScreen(
                  key: TodoKeys.editTodoScreen,
                  updateTodo: updateTodo,
                  addTodo: addTodo,
                  todo: todo,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
