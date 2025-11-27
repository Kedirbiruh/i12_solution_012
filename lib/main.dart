import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/providers/providers.dart';
import 'package:i12_into_012/screens/todo_list_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ffi for sqflite_common_ffi
  sqfliteFfiInit();

  // Set the databaseFactory to ffi version
  databaseFactory = databaseFactoryFfi;
  
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    return Builder(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: settings.isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
            ),
            useMaterial3: true,
          ),

          home: TodoListScreen(),
        );
      },
    );
  }
}
