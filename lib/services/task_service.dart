import 'package:sqflite/sqflite.dart';
import 'package:tasks/models/task.dart';
import 'db_service.dart';

class TaskService {
  Future<int> insert(Task task) async {
    Database db = await DBService.instance.database;

    await db.insert(DBService.TABLE_TASK, task.toMap());
  }

  Future<List<Task>> listAll() async {
    Database db = await DBService.instance.database;

    List<Task> response = [];

    List<Map> response_db =
        await db.rawQuery("SELECT * FROM ${DBService.TABLE_TASK}");

    for (Map map in response_db) {
      response.add(Task.toTask(map));
    }

    return response;
  }

  Future<List<Task>> findTasks(String valor) async {
    Database db = await DBService.instance.database;

    List<Task> response = [];
    List<Map> response_db = await db.rawQuery(
        "SELECT * FROM ${DBService.TABLE_TASK} WHERE ${DBService.TASK_TITLE} LIKE ? ",
        ["%$valor%"]);

    for (Map map in response_db) {
      response.add(Task.toTask(map));
    }

    return response;
  }

  Future<void> remove(int id) async {
    Database db = await DBService.instance.database;
    await db.rawDelete(
        "DELETE FROM ${DBService.TABLE_TASK} WHERE ${DBService.TASK_ID} = ? ",
        [id]);
  }

  Future<void> update(Task task) async {
    Database db = await DBService.instance.database;
    await db.update(DBService.TABLE_TASK, task.toMap(),
        where: "${DBService.TASK_ID} = ?", whereArgs: [task.id]);
  }
}
