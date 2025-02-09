import 'package:flutter/material.dart';
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
    if(taskController.text.isNotEmpty){
      setState(() {
        task.add(Task(id: task.length+1, title: taskController.text));
        taskController.clear();
      });
    }
  }
  void deleteTask(int index){
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
            'Todo Tasks',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 8, 64, 82),
            ),
          ),
          centerTitle: true,
          elevation: 10,
          backgroundColor: Color.fromARGB(255, 196, 224, 245),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 10, right: 16, left: 16),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    hintText: "Add new Task",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 8, 64, 82), width: 2.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                  ),
                )),
                IconButton(
                    onPressed: addTask,
                    icon: Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 8, 64, 82),
                    )),
                SizedBox(height: 10),
              ],
            ),
            SizedBox(height: 35),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "All Tasks",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 8, 64, 82),
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Expanded(child: ListView.builder(
            itemCount: task.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Checkbox(
                      value: task[index].done,
                      onChanged: (value) => doneTask(index),
                      activeColor: Colors.transparent,
                      checkColor:  Color.fromARGB(255, 8, 64, 82),
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
                          icon: const Icon(Icons.delete, color:  Color.fromARGB(255, 8, 64, 82)),
                          onPressed: () => deleteTask(index),
                        ),
                   ),

                ),
              );
            })),
          ]),
        ));
  }
}
