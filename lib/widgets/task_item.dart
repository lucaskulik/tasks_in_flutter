import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';

class TaskItem extends StatelessWidget {
  Task _task;
  Function onRemove;

  TaskItem(this._task, this.onRemove);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Text(_task.title),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
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
