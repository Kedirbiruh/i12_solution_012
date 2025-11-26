import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/app_state_controller.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/providers/app_state_notifier.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String databaseName = 'todo_app_items.db';

final databaseProvider = FutureProvider<Database>((ref) async {
  var databasesPath = await getDatabasesPath();
  final path = join(databasesPath, databaseName);
  try {
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Todo (id TEXT PRIMARY KEY, text TEXT, isCompleted INTEGER)',
        );
      },
    );
    return database;
  } catch (e) {
    log('Failed to open database at $path: $e');
    rethrow;
  }
});

class SqliteNotifier extends AppStateNotifier {
  final Ref _ref;

  SqliteNotifier(this._ref, AppState initialState) : super(initialState) {
    loadTodos();
  }

  AppstateController controller = AppstateController();

  Future<void> loadTodos() async {
    final db = await _ref.read(databaseProvider.future);
    final todoMaps = await db.query('Todo');
    state = AppState.todosFromJson(todoMaps);
  }

  @override
  Future<void> toggleTodo(String id) async {
    final newTodo = controller.toggleTodo(state, id);
    if (!await _addTodo(newTodo)) state = controller.state;
  }

  @override
  Future<void> addTodo(String text) async {
    final newTodo = controller.addTodo(state, text);
    if (!await _addTodo(newTodo)) state = controller.state;
  }

  @override
  Future<void> deleteTodo(String id) async {
    final deletedTodo = controller.deleteTodo(state, id);
    if (!await _deleteTodo(deletedTodo)) state = controller.state;
  }

  Future<bool> _addTodo(Todo item) async {
    final db = await _ref.read(databaseProvider.future);
    try {
      await db.insert(
        'Todo',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } on DatabaseException catch (e) {
      log('Failed to insert item "${item.toJson()}: $e"');
      return false;
    }
  }

  Future<bool> _deleteTodo(Todo item) async {
    final db = await _ref.read(databaseProvider.future);
    try {
      await db.delete(
        'Todo',
        // Use a `where` clause to delete a specific dog.
        where: 'id = ?',
        whereArgs: [item.id],
      );
      return true;
    } on DatabaseException catch (e) {
      log('Failed to delete item "${item.toJson()}: $e"');
      return false;
    }
  }
}
