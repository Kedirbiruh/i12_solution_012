import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/widgets/add_todo_dialog.dart';
import '../providers/app_state_notifier.dart';
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
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appState.todos.length,
              itemBuilder: (context, index) {
                final todo = appState.todos[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 213, 205, 205),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          todo.isCompleted
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: todo.isCompleted ? Colors.green : Colors.grey,
                          size: 28,
                        ),
                        onPressed: () => notifier.toggleTodo(todo.id),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          todo.text,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87, // gut lesbar
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 152, 70, 70),
                          size: 28,
                        ),
                        onPressed: () => notifier.deleteTodo(todo.id),
                      ),
                    ],
                  ),
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
        backgroundColor: const Color.fromARGB(255, 75, 71, 71),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
