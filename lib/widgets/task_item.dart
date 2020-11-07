import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks/models/image.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/widgets/task_image_form_item.dart';

class TaskItem extends StatelessWidget {
  Task _task;
  Function onChange;
  Function onRemoveImage;

  TaskItem(this._task, this.onChange, {this.onRemoveImage});

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
          const SizedBox(
            height: 20,
          ),
          _task.images.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _task.images.length,
                    itemBuilder: (_, index) {
                      ImageModel image = _task.images[index];
                      if (image != null)
                        return TaskImageFormItem(
                          image.id,
                          image.base64,
                          onRemove: this.onRemoveImage,
                        );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
