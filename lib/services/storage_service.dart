import 'dart:ffi';
import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart' show Todo;

class StorageService {
  void saveAppState(AppsState) {
    // TODO Implement
  }
  AppState loadAppState() => AppState(
    todos: [
      Todo(id: 'a', text: 'Zeug reinbringen', isCompleted: false),
      Todo(id: 'b', text: 'Hausaufgaben planen', isCompleted: true),
    ],
    isDarkMode: false,
    asksForDeletionConfirmation: true,
  );
}
