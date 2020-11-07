import 'package:flutter/material.dart';
import 'package:tasks/models/image.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/camera_screen.dart';
import 'package:tasks/widgets/task_image_form_item.dart';

class TaskForm extends StatefulWidget {
  Function saveMethod;
  VoidCallback onError;

  TaskForm(this.saveMethod);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  Task _task = new Task();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Tarefa"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Título",
                    hintStyle: TextStyle(color: Colors.red),
                    labelText: "Título",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Campo Obrigatório";

                    return null;
                  },
                  onSaved: (value) {
                    _task.title = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: "Descrição",
                    hintStyle: TextStyle(color: Colors.red),
                    labelText: "Descrição",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  onSaved: (value) {
                    _task.description = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _task.images.length + 1,
                    itemBuilder: (_, index) {
                      if (index > _task.images.length - 1) {
                        return _takePicture(context);
                      } else {
                        ImageModel image = _task.images[index];
                        if (image != null)
                          return TaskImageFormItem(index, image.base64);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      print(
                          " Título ${_task.title}  Descrição ${_task.description} ");

                      // _task.title = _titleController.value.text;
                      // _task.description = _descriptionController.value.text;

                      widget.saveMethod(_task);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Salvar"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addImage(String image) {
    setState(() {
      _task.images.add(ImageModel(base64: image));
    });
  }

  _takePicture(BuildContext context) {
    return Card(
        child: AspectRatio(
      aspectRatio: 0.5,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CameraScreen(_addImage),
            ),
          );
        },
        child: Container(
          color: Colors.black.withAlpha(100),
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
      ),
    ));
  }
}
