import 'package:tasks/services/db_service.dart';

class ImageModel {
  int id;
  int task_id;
  String base64;

  ImageModel({this.base64});

  Map<String, dynamic> toMap() {
    return {
      DBService.IMAGE_ID: id,
      DBService.IMAGE_TASK_ID: task_id,
      DBService.IMAGE_BASE64: base64
    };
  }

  ImageModel.toImage(Map<String, dynamic> map) {
    id = map[DBService.IMAGE_ID] ?? null;
    task_id = map[DBService.IMAGE_TASK_ID] ?? null;
    base64 = map[DBService.IMAGE_BASE64] ?? null;
  }
}
