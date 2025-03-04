// ignore_for_file: sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/constants.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/models/task_data.dart';
import 'package:todo_list/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks;

  getTasks() async {
    tasks = await DatabaseService.getTasks();
    Provider.of<TaskData>(context, listen: false).tasks = tasks!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);

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
      body: tasks == null
          ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ConstantColor.primary),))
          : Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 10, right: 16, left: 16),
              child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Todo Tasks (${tasks?.length})",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: ConstantColor.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                TaskList(taskData),
              ]),
            ),
      floatingActionButton: FloatingButton(taskData),
    );
  }

  Widget TaskList(TaskData taskData) {
    return Expanded(
        child: ListView.builder(
            itemCount: tasks?.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: tasks?[index].done,
                    onChanged: (value) => taskData.updateTask(tasks![index]),
                    activeColor: Colors.transparent,
                    checkColor: ConstantColor.primary,
                  ),
                  title: Text(
                    tasks![index].title,
                    style: TextStyle(
                      decoration: tasks![index].done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 25,
                    child: IconButton(
                      icon: const Icon(Icons.delete,
                          color: ConstantColor.primary),
                      onPressed: () => taskData.deleteTask(tasks![index]),
                    ),
                  ),
                ),
              );
            }));
  }

  Widget FloatingButton(TaskData taskData) {
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
                        if (taskController.text.isNotEmpty) {
                          taskData.addTask(taskController.text);
                          taskController.clear();
                          Navigator.pop(context);
                        }
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
