import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';
import '../models/app_state.dart';
import '../models/todo.dart';
import '../services/storage_service.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final refAppState = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return AppStateNotifier(storage);
});

class AppStateNotifier extends StateNotifier<AppState> {
  final StorageService _storageService;
  final _uuid = const Uuid();

  AppStateNotifier(this._storageService) : super(const AppState()) {
    loadState();
  }

  Future<void> loadState() async {
    final loaded = await _storageService.loadAppState();
    if (loaded != null) state = loaded;
  }

  Future<void> saveState() async {
    await _storageService.saveAppState(state);
  }

  void addTodo(String text) {
    if (text.trim().isEmpty) return;
    final newTodo = Todo(id: _uuid.v4(), text: text.trim());
    state = state.copyWith(todos: [...state.todos, newTodo]);
    saveState();
  }

  void toggleTodo(String id) {
    state = state.copyWith(
      todos: state.todos
          .map((t) => t.id == id ? t.copyWith(isCompleted: !t.isCompleted) : t)
          .toList(),
    );
    saveState();
  }

  void deleteTodo(String id) {
    state = state.copyWith(
      todos: state.todos.where((t) => t.id != id).toList(),
    );
    saveState();
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    saveState();
  }

  void toggleDeletionConfirmation() {
    state = state.copyWith(
      asksForDeletionConfirmation: !state.asksForDeletionConfirmation,
    );
    saveState();
  }
}
