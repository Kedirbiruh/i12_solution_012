import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/models/todo_list_controller.dart';
import 'package:i12_into_012/providers/todo_notifier_interface.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/*
final refAppState = StateNotifierProvider<AppStateNotifier, AppState>(
  (ref) => AppStateNotifier(),
);
*/

const String todoListFileName = 'todo_list.json';

final jsonFileProvider = FutureProvider<File>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final path = join(dir.path, todoListFileName);
  return File(path);
});

class JsonNotifier extends Notifier<List<Todo>>
    implements TodoNotifierInterface {
  final controller = TodoListController();

  @override
  List<Todo> build() {
    _init();
    return [];
  }

  Future<void> _init() async {
    final loaded = await loadTodoList();

    if (loaded != null && loaded.isNotEmpty) {
      state = loaded;
    } else {
      state = [];
      /*
       * Mögliche Standarditems
        todos: [
          Todo.create('Einkaufen gehen'),
          Todo.create('Flutter üben'),
          Todo.create('Zimmer aufräumen'),
        ],
        */
      //await storage.saveAppState(state);
    }
  }

  @override
  Future<void> addTodo(String text) async {
    controller.addTodo(state, text);
    if (await _save()) state = controller.state;
  }

  @override
  Future<void> toggleTodo(String id) async {
    controller.toggleTodo(state, id);
    if (await _save()) state = controller.state;
  }

  @override
  Future<void> deleteTodo(String id) async {
    controller.deleteTodo(state, id);
    if (await _save()) state = controller.state;
  }

  Future<bool> _save() async {
    final file = await ref.read(jsonFileProvider.future);
    try {
      await file.writeAsString(jsonEncode(controller.toJson(state)));
      return true;
    } on FileSystemException catch (e) {
      log('Failed to write file "${file.path}: $e"');
      return false;
    }
  }

  Future<List<Todo>?> loadTodoList() async {
    final file = await ref.read(jsonFileProvider.future);
    try {
      if (!await file.exists()) return null;
      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      // todos: [{id: 2131, text: asdasdsa, isDone}, ...]
      final todosJson = jsonMap['todos'] as List?;
      return todosJson != null
          ? todosJson
                .map((e) => Todo.fromJson(e as Map<String, dynamic>))
                .toList()
          : <Todo>[];
    } catch (e) {
      log('Error loading todo list from file "${file.path}": $e');
      return null;
    }
  }
}
