import 'package:flutter_riverpod/legacy.dart';
import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/services/storage_service.dart';

final refAppState = StateNotifierProvider<AppStateNotifier, AppState>(
  (ref) => AppStateNotifier(),
);

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState()) {
    _init();
  }

  Future<void> _init() async {
    final storage = StorageService();
    final loaded = await storage.loadAppState();

    if (loaded != null && loaded.todos.isNotEmpty) {
      state = loaded;
    } else {
      state = state.copyWith(
        todos: [
          Todo.create('Einkaufen gehen'),
          Todo.create('Flutter üben'),
          Todo.create('Zimmer aufräumen'),
        ],
      );
      await storage.saveAppState(state);
    }
  }

  void addTodo(String text) {
    final newTodo = Todo.create(text);
    state = state.copyWith(todos: [...state.todos, newTodo]);
    _save();
  }

  void toggleTodo(String id) {
    state = state.copyWith(
      todos: state.todos
          .map((t) => t.id == id ? t.copyWith(isCompleted: !t.isCompleted) : t)
          .toList(),
    );
    _save();
  }

  void deleteTodo(String id) {
    state = state.copyWith(
      todos: state.todos.where((t) => t.id != id).toList(),
    );
    _save();
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    _save();
  }

  void toggleDeletionConfirmation() {
    state = state.copyWith(
      asksForDeletionConfirmation: !state.asksForDeletionConfirmation,
    );
    _save();
  }

  Future<void> _save() async {
    final storage = StorageService();
    await storage.saveAppState(state);
  }
}
