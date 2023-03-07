import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../components/task_tile.dart';
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
              IconButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => FormScreen(
                                      onCreate: (Task newTask) {
                                        final addTask =
                                            Provider.of<TaskManager>(context,
                                                    listen: false)
                                                .addTask;
                                        addTask(newTask);
                                        Navigator.of(context).pop();
                                      },
                                      onUpdate: (_) {},
                                      isUpdating: false,
                                    )))
                      },
                  icon: const Icon(Icons.add))
            ]),
        body: SizedBox(
          width: width,
          child: Consumer<TaskManager>(
            builder: (context, taskManager, child) {
              final tasks = taskManager.tasks;

              if (tasks.isEmpty) {
                return const Center(child: Text('No tasks today! Add one~'));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskTile(
                        title: task.name,
                        description: task.description,
                        content: task.content,
                        isDone: task.isDone,
                        color: task.color,
                    );
                  },
                  itemCount: tasks.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16.0);
                  },
                ),
              );
            },
          ),
        ));
  }
}
