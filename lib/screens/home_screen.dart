// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todo_list/constants/constants.dart';
import 'package:todo_list/models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController taskController = TextEditingController();
  final List<Task> task = Task.task();
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        task.add(Task(id: task.length + 1, title: taskController.text));
        taskController.clear();
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      task.removeAt(index);
    });
  }

  void doneTask(int index) {
    setState(() {
      task[index].done = !task[index].done;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo Tracker',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: ConstantColor.secondary,
        foregroundColor: ConstantColor.primary,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 10, right: 16, left: 16),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Todo Tasks (${task.length})",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                color: ConstantColor.primary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          TaskList(),
        ]),
      ),
      floatingActionButton: FloatingButton(),
    );
  }

  Widget TaskList() {
    return Expanded(
        child: ListView.builder(
            itemCount: task.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: task[index].done,
                    onChanged: (value) => doneTask(index),
                    activeColor: Colors.transparent,
                    checkColor: ConstantColor.primary,
                  ),
                  title: Text(
                    task[index].title,
                    style: TextStyle(
                      decoration: task[index].done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 25,
                    child: IconButton(
                      icon: const Icon(Icons.delete,
                          color: ConstantColor.primary),
                      onPressed: () => deleteTask(index),
                    ),
                  ),
                ),
              );
            }));
  }

  Widget FloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add task"),
                content: TextField(
                  controller: taskController,
                  decoration: InputDecoration(hintText: "Enter new task"),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancle",
                        style: TextStyle(color: ConstantColor.primary),
                      )),
                  TextButton(
                      onPressed: () {
                        addTask();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(color: ConstantColor.primary),
                      ))
                ],
              );
            });
      },
      backgroundColor: Color.fromARGB(255, 8, 64, 82),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      tooltip: "add a new task",
    );
  }
}
