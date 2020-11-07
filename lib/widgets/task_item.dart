import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';

class TaskItem extends StatelessWidget {
  Task _task;
  Function onChange;

  TaskItem(this._task, this.onChange);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Text(_task.title),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        trailing: Checkbox(
          value: _task.done ?? false,
          onChanged: (value) {
            this.onChange(_task, value);
          },
        ),
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "Descrição",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(_task.description),
          ),
        ],
      ),
    );
  }
}
