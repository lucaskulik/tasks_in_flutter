import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task_form.dart';
import 'package:tasks/services/task_service.dart';
import 'package:tasks/widgets/task_item.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskService _taskService = new TaskService();

  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    _listTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          return TaskItem(tasks[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskForm(_saveTask),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _saveTask(valor) async {
    await _taskService.insert(valor);
    _listTasks();
  }

  _listTasks() async {
    List<Task> localTasks = await _taskService.listAll();
    setState(() {
      tasks = localTasks ?? [];
    });
  }
}
