// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_arch_todo_vanilla/core/keys.dart';
import 'package:flutter_arch_todo_vanilla/core/localization/app_localizations.dart';
import 'package:flutter_arch_todo_vanilla/data/app_state.dart';

class ExtraActionsButton extends StatelessWidget {
  final PopupMenuItemSelected<ExtraAction> onSelected;
  final bool allComplete;
  final bool hasCompletedTodos;

  ExtraActionsButton({
    this.onSelected,
    this.allComplete = false,
    this.hasCompletedTodos = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      key: TodoKeys.extraActionsButton,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
            PopupMenuItem<ExtraAction>(
              key: TodoKeys.toggleAll,
              value: ExtraAction.toggleAllComplete,
              child: Text(allComplete
                  ? TodoLocalizations.of(context).markAllIncomplete
                  : TodoLocalizations.of(context).markAllComplete),
            ),
            PopupMenuItem<ExtraAction>(
              key: TodoKeys.clearCompleted,
              value: ExtraAction.clearCompleted,
              child: Text(TodoLocalizations.of(context).clearCompleted),
            ),
          ],
    );
  }
}
