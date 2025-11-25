import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/json_notifier.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(refAppState);
    final notifier = ref.read(refAppState.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: appState.isDarkMode,
            onChanged: (_) => notifier.toggleDarkMode(),
          ),
          SwitchListTile(
            title: const Text('Vor dem Löschen nachfragen'),
            value: appState.asksForDeletionConfirmation,
            onChanged: (_) => notifier.toggleDeletionConfirmation(),
          ),
        ],
      ),
    );
  }
}

