import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/domain/repository/hive_todo_repo.dart';
import 'package:flutter_todo_bloc/presenation/todo_page.dart';
import 'package:flutter_todo_bloc/presenation/todo_view.dart';
import 'package:flutter_todo_bloc/data/models/todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final HiveTodoRepo hiveTodoRepo = HiveTodoRepo();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: const TextStyle(color: Colors.white, fontSize: 18),
          bodyMedium: const TextStyle(color: Colors.white70, fontSize: 16),
          bodySmall: const TextStyle(color: Colors.white54, fontSize: 14),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TodoPage(todoRepo: hiveTodoRepo,),
    );
  }
}
