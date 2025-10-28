import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/app_state.dart' show AppState;
import 'package:i12_into_012/models/todo.dart' show Todo;

final refAppState = NotifierProvider<AppStateNotifier, AppState>(
  () => AppStateNotifier(),
);

class AppStateNotifier extends Notifier<AppState> {
  @override
  AppState build() => AppState(
    todos: [
      Todo(id: 'a', text: 'Müll rausbringen', isCompleted: false),
      Todo(id: 'b', text: 'Hausaufgaben machen', isCompleted: true),
    ],

    isDarkMode: false,
    asksForDeletionConfirmation: true,
  );
}
