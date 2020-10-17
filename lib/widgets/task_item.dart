import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';

class TaskItem extends StatelessWidget {
  Task _task;

  TaskItem(this._task);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: ExpansionTile(
        title: Text(_task.title),
        subtitle: Text(_task.description),
        trailing: Text(_task.description),
      ),
    );
  }
}
