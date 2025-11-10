import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/app_state.dart';

class StorageService {
  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todo_app_state.json');
  }

  Future<void> saveAppState(AppState state) async {
    final file = await _localFile;
    await file.writeAsString(jsonEncode(state.toJson()));
  }

  Future<AppState?> loadAppState() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) return null;
      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppState.fromJson(jsonMap);
    } catch (e) {
      print('Error loading app state: $e');
      return null;
    }
  }
}
