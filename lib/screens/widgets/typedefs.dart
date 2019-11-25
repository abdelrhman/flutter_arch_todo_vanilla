import 'package:flutter_arch_todo_vanilla/data/app_state.dart';

typedef TodoAdder(Todo todo);

typedef TodoRemover(Todo todo);

typedef TodoUpdater(
  Todo todo, {
  bool complete,
  String id,
  String note,
  String task,
});
