import 'package:flutter/material.dart';

import '../components/task.dart';
import './form_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: theme.primaryColor,
            title: const Text('Todo App'),
            actions: [
              IconButton(onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FormScreen())
                )
              }, icon: const Icon(Icons.add))
            ]),
        body: Container(
          padding: EdgeInsets.only(top: 16.0),
          width: width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Task(
              title: "Test",
              description: "Test",
              isDone: true,
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Task(
              title: "Test",
              description: "Test",
              isDone: false,
            )
          ]),
        ));
  }
}
