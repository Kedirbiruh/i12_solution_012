import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/providers/app_state_notifier.dart';

class TodoListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext, WidgetRef ref) {
    final appState = ref.watch(refAppState);
    final appStateNotifier = ref.watch(refAppState.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Screen'),
      ),
      body: Column(
        children: [
          Text('nur so'),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(child: Text('Dark Mode')),
                Switch(
                  value: appState.isDarkMode,
                  onChanged: (isDarkMode) {
                    appStateNotifier.toggleDarkMode();
                  },
                ),
              ],
            ),
          ),
          Text('am ende'),
        ],
      ),
    );
  }
}
