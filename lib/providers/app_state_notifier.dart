import 'package:flutter_riverpod/legacy.dart';
import 'package:i12_into_012/models/app_state.dart';

abstract class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier(AppState state) : super(state);
  void addTodo(String text);
  void toggleTodo(String id);
  void deleteTodo(String id);
}
