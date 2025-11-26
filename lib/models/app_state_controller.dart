import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';


class AppstateController {
  AppState? _state;
  Todo toggleTodo(AppState state, String id) {
    _state = state.copyWith(
      todos: state.todos
          .map((t) => t.id == id ? t.copyWith(isCompleted: !t.isCompleted) : t)
          .toList(),
    );
    return state.todos.firstWhere((todo) => todo.id == id);
  }

  AppState get state {
    if (_state == null)
    throw Exception('Trying to access null-state');
    return _state!;
  }

  Todo deleteTodo(AppState state, String id) {
    _state = state.copyWith(
      todos: state.todos.where((t) => t.id != id).toList(),
    );
    return state.todos.firstWhere((todo) => todo.id == id);
  }

  Todo addTodo(AppState state, String text) {
    final newTodo = Todo.create(text);
    _state = state.copyWith(todos: [...state.todos, newTodo]);
    return newTodo;
  }
}
