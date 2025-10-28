import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Screen'),
      ),
    );
  }
}
