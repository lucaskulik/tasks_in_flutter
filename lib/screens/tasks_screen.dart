import 'package:flutter/material.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task_form.dart';
import 'package:tasks/services/task_service.dart';
import 'package:tasks/widgets/search_widget.dart';
import 'package:tasks/widgets/task_item.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskService _taskService = new TaskService();
  String search;

  List<Task> tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTasks();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: Column(
        children: [
          SearchWidget(listTasks, search),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await listTasks();
                return null;
              },
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Dismissible(
                      background: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      key: ValueKey(tasks[index]),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart)
                          _onRemove(tasks[index]);
                      },
                      direction: DismissDirection.endToStart,
                      child: TaskItem(tasks[index], _onRemove),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
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
    listTasks();
  }

  listTasks({String valor = null}) async {
    List<Task> localTasks;
    if (valor != null && valor.isNotEmpty) {
      localTasks = await _taskService.findTasks(valor);
    } else {
      localTasks = await _taskService.listAll();
    }

    setState(() {
      search = valor;
      tasks = localTasks ?? [];
    });
  }

  _onRemove(Task task) {
    print("Remover");
    _taskService.remove(task.id);
    listTasks();
  }
}
