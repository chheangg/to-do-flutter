import 'package:flutter/painting.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final String content;
  final bool isDone;
  final DateTime timestamp;
  final Color color;

  const Task(
      {required this.id,
      required this.name,
      required this.description,
      required this.content,
      required this.isDone,
      required this.timestamp,
      required this.color});

  Task copyWith({
    String? id,
    String? name,
    String? description,
    String? content,
    bool? isDone,
    DateTime? timestamp,
    Color? color,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
      timestamp: timestamp ?? this.timestamp,
      color: color ?? this.color,
    );
  }
}
