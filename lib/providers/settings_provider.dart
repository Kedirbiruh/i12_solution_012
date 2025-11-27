import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/settings.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const String settingsFileName = 'settings.json';

class SettingsNotifier extends Notifier<Settings> {
  late File _file;

  @override
  Settings build() {
    // Start async setup
    _init();
    return const Settings();
  }

  Future<void> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, settingsFileName);
    _file = File(path);  //('${dir.path}/$settingsFileName');

    if (await _file.exists()) {
      final jsonString = await _file.readAsString();
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      state = Settings.fromJson(json);
    } else {
      state = const Settings();
    }
  }

  Future<void> _save(Settings s) async {
    await _file.writeAsString(jsonEncode(s.toJson()));
  }

  Future<void> toggleIsDarkMode() async {
    final updated = state.copyWith(isDarkMode: !state.isDarkMode);
    state = updated;
    await _save(updated);
  }

  Future<void> toggleAskConfirmationBeforeDelete() async {
    final updated = state.copyWith(
      askConfirmationBeforeDelete: !state.askConfirmationBeforeDelete,
    );
    state = updated;
    await _save(updated);
  }
}
