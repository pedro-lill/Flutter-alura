import 'package:flutter/material.dart';
import 'package:curso/Components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/flutter.png', 4),
    Task('Andar de Bike', 'assets/images/bike.jpg', 2),
    Task('Meditar', 'assets/images/meditar.jpeg', 5),
    Task('Ler', 'assets/images/ler.jpg', 3),
    Task('Jogar', 'assets/images/jogar.jpg', 1),
  ];

  void newTask(String nome, String photo, int difficulty) {
    taskList.add(Task(nome, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  } 

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
