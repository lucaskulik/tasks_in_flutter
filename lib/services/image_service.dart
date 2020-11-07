import 'package:sqflite/sqflite.dart';
import 'package:tasks/models/image.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/services/db_service.dart';

class ImageService {
  Future<int> insert(ImageModel imageModel) async {
    Database db = await DBService.instance.database;

    return await db.insert(DBService.TABLE_IMAGE, imageModel.toMap());
  }

  Future<List<ImageModel>> getImagesByTask(Task task) async {
    Database db = await DBService.instance.database;

    List<Map<String, dynamic>> result = await db.query(DBService.TABLE_IMAGE,
        where: "${DBService.IMAGE_TASK_ID} = ? ", whereArgs: [task.id]);

    // print("IMAGENS ${result.length}");
    List<ImageModel> images = [];

    if (result.isNotEmpty) {
      images = result.map((row) => ImageModel.toImage(row)).toList();
    }

    return images;
  }

  Future<void> remove(ImageModel imageModel) async {
    Database db = await DBService.instance.database;
    await db.delete(DBService.TABLE_IMAGE,
        where: "${DBService.IMAGE_ID} = ?", whereArgs: [imageModel.id]);
  }

  Future<void> removeById(int id) async {
    Database db = await DBService.instance.database;
    await db.delete(DBService.TABLE_IMAGE,
        where: "${DBService.IMAGE_ID} = ?", whereArgs: [id]);
  }
}
