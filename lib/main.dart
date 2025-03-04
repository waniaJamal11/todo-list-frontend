import 'package:flutter/material.dart';
import 'package:todo_list/models/task_data.dart';
import 'package:todo_list/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>( 
       create: (context) => TaskData(),
    child:MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen()  
      }
    ),
    );
  }
}

