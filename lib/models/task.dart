import 'package:flutter/material.dart';

class Task {
  final int id;
  final String title;
  bool done;

  Task({
    required this.id,
    required this.title,
    this.done = false,
  });

  static List<Task> task() {
    return [
      Task(id: 1, title: "Complete Flutter project"),
      Task(id: 2, title: "Read a programming book"),
      Task(id: 3, title: "Go for a walk", done: true),
      Task(id: 4, title: "Buy groceries"),
      Task(id: 5, title: "Workout for 30 minutes"),
       
    ];
  }
}
