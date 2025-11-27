import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final notifier = ref.read(settingsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: settings.isDarkMode,
            onChanged: (_) => notifier.toggleDarkMode(),
          ),
          SwitchListTile(
            title: const Text('Vor dem Löschen nachfragen'),
            value: settings.askConfirmationBeforeDelete,
            onChanged: (_) => notifier.toggleAskConfirmationBeforeDelete(),
          ),
        ],
      ),
    );
  }
}

