import 'package:flutter/foundation.dart';

class Todo {
  final String id;
  final String text;
  final bool isCompleted;

  Todo(
    {required this.id, required this.text, required this.isCompleted});

  Map<String, dynamic> toJson() => {
    // herleiten
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    // herleiten
    id: '',
    text: '',
    isCompleted: false,
  );

  Todo copyWith(String? id, String? text, bool? isCompleted) => Todo(
    // herleiten
    id: '',
    text: '',
    isCompleted: false,
  );
}
