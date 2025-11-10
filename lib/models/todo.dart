import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String text;
  final bool isCompleted;

  const Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  factory Todo.create(String text) {
    return Todo(
      id: const Uuid().v4(),
      text: text,
      isCompleted: false,
    );
  }

  Todo copyWith({String? id, String? text, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'isCompleted': isCompleted,
  };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      text: json['text'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
