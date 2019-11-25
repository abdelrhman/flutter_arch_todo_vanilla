import 'package:flutter/material.dart';
import 'package:flutter_arch_todo_vanilla/data/todo_repository_impl.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'data/file_storage.dart';
import 'data/web_client.dart';

void main() {
  runApp(
    TodoApp(
      repository: TodoRepositoryImpl(
        fileStorage: FileStorage(
          "vanilla_app",
          getApplicationDocumentsDirectory,
        ),
        webClient: WebClient(),
      ),
    ),
  );
}
