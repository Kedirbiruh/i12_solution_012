import 'package:i12_into_012/models/todo.dart';

class AppState {
  final List<Todo> todos;
  bool isDarkMode;
  bool asksForDeletionConfirmation;

  AppState({
    required this.todos,
    required this.isDarkMode,
    required this.asksForDeletionConfirmation,
  });

  Map<String, dynamic> toJson() => {
    // herleiten
  };

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
    // herleiten
    todos: [],
    isDarkMode: false,
    asksForDeletionConfirmation: false,
  );

  AppState copyWith({
    List<Todo>? todos,
    bool? isDarkMode,
    bool? asksForDeletionConfirmation,
  }) =>
      AppState(
        todos: todos ?? this.todos, 
        isDarkMode: isDarkMode ?? this.isDarkMode, 
        asksForDeletionConfirmation: asksForDeletionConfirmation ?? this.asksForDeletionConfirmation,);
}
