import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';

class TodoListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(refAppState);
    final todos = appState.todos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List Screen'),
      ),
      body: Column(
        children: [
          for (final todo in todos)
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
                  Expanded(child: Text(todo.text)),
                  if (todo.isCompleted)
                    Icon(
                      Icons.circle_outlined,
                      color: Theme.of(context).primaryColor,
                    )
                  else
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
