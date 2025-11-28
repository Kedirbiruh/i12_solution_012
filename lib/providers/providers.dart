import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/settings.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/providers/json_notifier.dart';
import 'package:i12_into_012/providers/settings_notifier.dart';
import 'package:i12_into_012/providers/sqlite_notifier.dart';

enum StorageBackend { SQLite, Json }

const storageBackendType = StorageBackend.SQLite;

final settingsNotifierProvider = NotifierProvider<SettingsNotifier, Settings>(
  SettingsNotifier.new,
);

final sqliteTodoProvider = NotifierProvider<SqliteNotifier, List<Todo>>(
  SqliteNotifier.new,
);
final jsonTodoProvider = NotifierProvider<JsonNotifier, List<Todo>>(
  JsonNotifier.new,
);

// so we use Notifier<List<Todo>> as the common notifier type.
final NotifierProvider<Notifier<List<Todo>>, List<Todo>> todoNotifierProvider =
    storageBackendType == StorageBackend.SQLite
    ? sqliteTodoProvider
    : jsonTodoProvider;

