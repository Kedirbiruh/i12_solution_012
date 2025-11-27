import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

int _boolToInt(bool value) => value ? 1 : 0;
bool _intToBool(int value) => value != 0;

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String text,
    @JsonKey(fromJson: _intToBool, toJson: _boolToInt)
    @Default(false)
    bool isCompleted,
  }) = _Todo;

  factory Todo.create(String text) => Todo(
    id: const Uuid().v4(),
    text: text,
  );

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
