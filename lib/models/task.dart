import 'package:tasks/services/db_service.dart';

class Task {
  int id;
  String title;
  String description;

  Task({this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      DBService.TASK_TITLE: title,
      DBService.TASK_DESCRIPTION: description
    };
  }

  Task.toTask(Map<String, dynamic> map) {
    id = map[DBService.TASK_ID];
    title = map[DBService.TASK_TITLE] ?? "";
    description = map[DBService.TASK_DESCRIPTION] ?? "";
  }
}
