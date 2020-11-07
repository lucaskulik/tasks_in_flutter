import 'package:sqflite/sqflite.dart';
import 'package:tasks/models/image.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/services/image_service.dart';
import 'db_service.dart';

class TaskService {
  ImageService _imageService = new ImageService();

  Future<int> insert(Task task) async {
    Database db = await DBService.instance.database;

    int id = await db.insert(DBService.TABLE_TASK, task.toMap());

    if (task.images != null && task.images.isNotEmpty) {
      task.images.forEach((image) {
        image.task_id = id;
        this._imageService.insert(image);
      });
    }
  }

  Future<List<Task>> listAll() async {
    Database db = await DBService.instance.database;

    List<Task> response = [];

    List<Map> response_db =
        await db.rawQuery("SELECT * FROM ${DBService.TABLE_TASK}");

    for (Map map in response_db) {
      response.add(Task.toTask(map));
    }

    for (Task task in response) {
      task.images = await this._imageService.getImagesByTask(task);
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

  Future<void> remove(Task task) async {
    if (task.images != null && task.images.isNotEmpty) {
      for (ImageModel image in task.images) {
        this._imageService.remove(image);
      }
    }

    Database db = await DBService.instance.database;
    await db.rawDelete(
        "DELETE FROM ${DBService.TABLE_TASK} WHERE ${DBService.TASK_ID} = ? ",
        [task.id]);
  }

  Future<void> update(Task task) async {
    Database db = await DBService.instance.database;
    await db.update(DBService.TABLE_TASK, task.toMap(),
        where: "${DBService.TASK_ID} = ?", whereArgs: [task.id]);
  }
}
