import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_state_notifier.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(refAppState);
    final notifier = ref.watch(refAppState.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: appState.isDarkMode,
              onChanged: (_) => notifier.toggleDarkMode(),
            ),
            SwitchListTile(
              title: const Text('Ask for Deletion Confirmation'),
              value: appState.asksForDeletionConfirmation,
              onChanged: (_) => notifier.toggleDeletionConfirmation(),
            ),
          ],
        ),
      ),
    );
  }
}
