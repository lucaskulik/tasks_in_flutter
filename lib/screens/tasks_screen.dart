import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task_form.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [
    Task(title: "Titulo", description: "Descrição"),
    Task(title: "Titulo 2", description: "Descrição 2"),
    Task(title: "Titulo 3", description: "Descrição 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          Task currentTask = tasks[index];

          return Card(
            elevation: 20,
            child: ListTile(
              title: Text(currentTask.title),
              subtitle: Text(currentTask.description),
              trailing: Text(currentTask.description),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskForm(_adicionarNovaTaskaLIsta),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _adicionarNovaTaskaLIsta(valor) {
    setState(() {
      tasks.add(valor);
    });
  }
}
