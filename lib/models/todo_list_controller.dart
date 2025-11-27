import 'dart:developer';

import 'package:i12_into_012/models/todo.dart';

class TodoListController {
  List<Todo>? _state;
  Todo toggleTodo(List<Todo> state, String id) {
    _state = state
        .map((t) => t.id == id ? t.copyWith(isCompleted: !t.isCompleted) : t)
        .toList();
    return _state!.firstWhere((todo) => todo.id == id);
  }

  List<Todo> get state {
    if (_state == null) throw Exception('Trying to access null-state');
    return _state!;
  }

  Todo deleteTodo(List<Todo> state, String id) {
    _state = state.where((t) => t.id != id).toList();
    return state.firstWhere((todo) => todo.id == id);
  }

  Todo addTodo(List<Todo> state, String text) {
    final newTodo = Todo.create(text);
    _state = [...state, newTodo];
    return newTodo;
  }

  List<Todo> todoListFromJson(List<Map<String, dynamic>> todoMap) {
    final List<Todo> todoList = [];
    for (final item in todoMap) {
      todoList.add(Todo.fromJson(item));
    }
    for (final x in todoList) {
      log('$x');
    }
    return todoList;
  }

  /*
   * todos: [{id: 124, text: "blah", isDone: true}, {}, ...]
   */
  Map<String, dynamic> toJson(List<Todo> todos) {
    return {
      'todos': todos.map((todo) => todo.toJson()).toList(),
    };
  }
}
