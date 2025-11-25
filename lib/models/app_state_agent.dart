import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';

class AppStateAgent {
  AppState addTodo(AppState state, String text) {
    final newTodo = Todo.create(text);
    return state.copyWith(todos: [...state.todos, newTodo]);
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
}