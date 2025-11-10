import 'package:i12_into_012/models/todo.dart';

class AppState {
  final List<Todo> todos;
  final bool isDarkMode;
  final bool asksForDeletionConfirmation;

  const AppState({
    this.todos = const [],
    this.isDarkMode = false,
    this.asksForDeletionConfirmation = true,
  });

  AppState copyWith({
    List<Todo>? todos,
    bool? isDarkMode,
    bool? asksForDeletionConfirmation,
  }) {
    return AppState(
      todos: todos ?? this.todos,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      asksForDeletionConfirmation:
          asksForDeletionConfirmation ?? this.asksForDeletionConfirmation,
    );
  }

  Map<String, dynamic>toJson () {
    return {
      'todos': todos.map((todo) => todo.toJson()).toList(),
      'isDarkMode': isDarkMode,
      'asksForDeletionConfirmation': asksForDeletionConfirmation,
    };
  }

  factory AppState.fromJson(Map<String, dynamic> json) {
    final todosJson = json['todos'] as List?;
    final todosList = todosJson != null
        ? todosJson
              .map((e) => Todo.fromJson(e as Map<String, dynamic>))
              .toList()
        : <Todo>[];

    return AppState(
      todos: todosList,
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      asksForDeletionConfirmation:
          json['asksForDeletionConfirmation'] as bool? ?? true,
    );
  }
}
