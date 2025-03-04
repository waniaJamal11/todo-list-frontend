import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/services/database_service.dart';

class TaskData extends ChangeNotifier{
  List <Task> tasks=[];
  

  void addTask(String taskTitle) async {
    Task task =await  DatabaseService.addTask(taskTitle);
    tasks.add(task);
    notifyListeners();
  }
    void updateTask(Task task) {
    task.toggle();
   DatabaseService.updateTask(task.id);
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    DatabaseService.deleteTask(task.id);
    notifyListeners();
  }
}