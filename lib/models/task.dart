import 'package:tasks/services/db_service.dart';

class Task {
  int id;
  String title;
  String description;
  bool done;

  Task({this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      DBService.TASK_ID: id,
      DBService.TASK_TITLE: title,
      DBService.TASK_DESCRIPTION: description,
      DBService.TASK_DONE: done != null && done == true ? 1 : 0
    };
  }

  Task.toTask(Map<String, dynamic> map) {
    id = map[DBService.TASK_ID];
    title = map[DBService.TASK_TITLE] ?? "";
    description = map[DBService.TASK_DESCRIPTION] ?? "";
    done = map[DBService.TASK_DONE] == 1 ? true : false;
  }
}
