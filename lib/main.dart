import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/form_screen.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo',
        theme:
            ThemeData(
              primaryColor: Colors.red[500],
              fontFamily: 'Open Sans',
              ),
        home: const FormScreen());
  }
}
