import 'package:flutter/material.dart';
import 'package:flutter_arch_todo_vanilla/data/model/todo_entity.dart';
import 'package:flutter_arch_todo_vanilla/data/todo_repository.dart';
import 'package:flutter_arch_todo_vanilla/data/web_client.dart';

import 'file_storage.dart';

class TodoRepositoryImpl implements TodosRepository{

  final FileStorage fileStorage;
  final WebClient webClient;

  const TodoRepositoryImpl({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<TodoEntity>> loadTodos() async {
    try {
      return await fileStorage.loadTodos();
    } catch (e) {
      final todos = await webClient.fetchTodos();

      fileStorage.saveTodos(todos);

      return todos;
    }
  }

  // Persists todos to local disk and the web
  @override
  Future saveTodos(List<TodoEntity> todos) {
    return Future.wait<dynamic>([
      fileStorage.saveTodos(todos),
      webClient.postTodos(todos),
    ]);
  }

}