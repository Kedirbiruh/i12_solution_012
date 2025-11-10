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

  /// 🆕 Factory-Methode, um bequem ein neues Todo zu erstellen
  factory Todo.create(String text) {
    return Todo(
      id: const Uuid().v4(),
      text: text,
      isCompleted: false,
    );
  }

  /// ✅ Zum Kopieren mit Änderungen (immutables Muster)
  Todo copyWith({String? id, String? text, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// 🔄 Für das lokale Speichern als JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'isCompleted': isCompleted,
      };

  /// 🔁 Umwandlung von JSON zurück in ein Todo
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      text: json['text'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
