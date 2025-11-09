import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_state_notifier.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(refAppState);
    final notifier = ref.read(refAppState.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
            title: const Text('Ask before deleting todos'),
            value: appState.asksForDeletionConfirmation,
            onChanged: (_) => notifier.toggleDeletionConfirmation(),
          ),
        ],
      ),
    );
  }
}
