import 'package:curso/Screens/initialScreen.dart';
import 'package:curso/data/task_inherited.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baita App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TaskInherited(
        child: const InitialScreen()
      ),
    );
  }
}
