// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  static m0(task) => "Deleted \"${task}\"";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "activeTodos" : MessageLookupByLibrary.simpleMessage("Active Todos"),
    "addTodo" : MessageLookupByLibrary.simpleMessage("Add Todo"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "clearCompleted" : MessageLookupByLibrary.simpleMessage("Clear completed"),
    "completedTodos" : MessageLookupByLibrary.simpleMessage("Completed Todos"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteTodo" : MessageLookupByLibrary.simpleMessage("Delete Todo"),
    "deleteTodoConfirmation" : MessageLookupByLibrary.simpleMessage("Delete this todo?"),
    "editTodo" : MessageLookupByLibrary.simpleMessage("Edit Todo"),
    "emptyTodoError" : MessageLookupByLibrary.simpleMessage("Please enter some text"),
    "filterTodos" : MessageLookupByLibrary.simpleMessage("Filter Todos"),
    "markAllComplete" : MessageLookupByLibrary.simpleMessage("Mark all complete"),
    "markAllIncomplete" : MessageLookupByLibrary.simpleMessage("Mark all incomplete"),
    "newTodoHint" : MessageLookupByLibrary.simpleMessage("What needs to be done?"),
    "notesHint" : MessageLookupByLibrary.simpleMessage("Additional Notes..."),
    "saveChanges" : MessageLookupByLibrary.simpleMessage("Save changes"),
    "showActive" : MessageLookupByLibrary.simpleMessage("Show Active"),
    "showAll" : MessageLookupByLibrary.simpleMessage("Show All"),
    "showCompleted" : MessageLookupByLibrary.simpleMessage("Show Completed"),
    "stats" : MessageLookupByLibrary.simpleMessage("Stats"),
    "todoDeleted" : m0,
    "todoDetails" : MessageLookupByLibrary.simpleMessage("Todo Details"),
    "todos" : MessageLookupByLibrary.simpleMessage("Todos"),
    "undo" : MessageLookupByLibrary.simpleMessage("Undo")
  };
}
