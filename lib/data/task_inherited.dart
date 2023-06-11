import 'package:first_project/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/Eu7m692XIAEvxxP.png', 3),
    Task('Andar de Bike', 'assets/images/images.png', 2),
    Task('Meditar', 'assets/images/plena-e1579805752463.jpg', 4),
    Task('Jogar', 'assets/images/jogos-825x450px.webp', 1),
    Task('Meditar na hora do almoço em dia de trabalho', 'assets/images/meditacao-no-trabalho-97077984.webp', 5)
  ];

  void newTask(String name, String photo, int difficulty){
      taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
