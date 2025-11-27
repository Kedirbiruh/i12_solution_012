import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/todo.dart';

abstract class TodoNotifierInterface {

  void addTodo(String text);
  void toggleTodo(String id);
  void deleteTodo(String id);
}
