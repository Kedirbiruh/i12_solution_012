import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/widgets/add_todo_dialog.dart';
import '../providers/app_state_notifier.dart';
import '../widgets/todo_item.dart';
import '../models/todo.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(refAppState);
    final notifier = ref.read(refAppState.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Aufgaben'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: appState.todos.length,
              itemBuilder: (context, index) {
                final todo = appState.todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: () => notifier.toggleTodo(todo.id),
                  onDelete: () => notifier.deleteTodo(todo.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AddTodoDialog(
            onAdd: (text) => notifier.addTodo(text),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
