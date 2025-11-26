import 'package:flutter_riverpod/legacy.dart';
import 'package:i12_into_012/models/settings.dart';

class SettingsStateNotifier extends StateNotifier<Settings> {
  SettingsStateNotifier() : super(const Settings()) {
    loadSettings();
  }

  Future<void> loadSettings() {
    
  }
}
