import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_manager.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo',
        theme: ThemeData(
          primaryColor: Colors.red[500],
          fontFamily: 'Open Sans',
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TaskManager())
          ],
          child: const Home(),
        ),
    );
  }
}
