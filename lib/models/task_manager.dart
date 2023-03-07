import 'package:flutter/material.dart';
import '../models/models.dart';

class TaskManager extends ChangeNotifier {
  final List<Task> _tasks = <Task>[];
  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(Task task) {
    _tasks.add(task);
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void updateTask(Task newTask) {
    _tasks[tasks.indexWhere((task) => task.id == newTask.id)] = newTask;
    notifyListeners();
  }

  void changeStatusTask(Task newTask) {
    _tasks[tasks.indexWhere((task) => task.id == newTask.id)] =
        newTask.copyWith(isDone: !newTask.isDone);
    notifyListeners();
  }
}
