// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_todo_vanilla/core/keys.dart';
import 'package:flutter_arch_todo_vanilla/core/localization/app_localizations.dart';

import 'package:flutter_arch_todo_vanilla/data/app_state.dart';
import 'package:flutter_arch_todo_vanilla/screens/widgets/typedefs.dart';

class AddEditScreen extends StatefulWidget {
  final Todo todo;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;

  AddEditScreen({
    Key key,
    @required this.addTodo,
    @required this.updateTodo,
    this.todo,
  }) : super(key: key ?? TodoKeys.addTodoScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing
            ? TodoLocalizations.of(context).editTodo
            : TodoLocalizations.of(context).addTodo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.todo != null ? widget.todo.task : '',
                key: TodoKeys.taskField,
                autofocus: isEditing ? false : true,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                    hintText: TodoLocalizations.of(context).newTodoHint),
                validator: (val) => val.trim().isEmpty
                    ? TodoLocalizations.of(context).emptyTodoError
                    : null,
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: widget.todo != null ? widget.todo.note : '',
                key: TodoKeys.noteField,
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: TodoLocalizations.of(context).notesHint,
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          key: isEditing
              ? TodoKeys.saveTodoFab
              : TodoKeys.saveNewTodo,
          tooltip: isEditing
              ? TodoLocalizations.of(context).saveChanges
              : TodoLocalizations.of(context).addTodo,
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              form.save();

              final task = _task;
              final note = _note;

              if (isEditing) {
                widget.updateTodo(widget.todo, task: task, note: note);
              } else {
                widget.addTodo(Todo(
                  task,
                  note: note,
                ));
              }

              Navigator.pop(context);
            }
          }),
    );
  }

  bool get isEditing => widget.todo != null;
}
