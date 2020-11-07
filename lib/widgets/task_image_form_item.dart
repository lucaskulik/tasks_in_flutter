import 'dart:convert';

import 'package:flutter/material.dart';

class TaskImageFormItem extends StatelessWidget {
  int index;
  String base64;
  Function onRemove;

  TaskImageFormItem(this.index, this.base64, {this.onRemove});

  @override
  Widget build(BuildContext context) {
    print(this.onRemove);
    return Card(
        child: AspectRatio(
      aspectRatio: 0.5,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Image.memory(
                  base64Decode(this.base64),
                ),
                actions: [
                  onRemove != null
                      ? TextButton(
                          onPressed: () {
                            this.onRemove(index);
                            Navigator.of(context).pop();
                          },
                          child: Text("Excluir"),
                        )
                      : Container(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Fechar"),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          color: Colors.black.withAlpha(100),
          child: Image.memory(
            base64Decode(this.base64),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }
}
