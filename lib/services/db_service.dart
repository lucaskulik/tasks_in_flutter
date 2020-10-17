import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  DBService._privateConstructor();
  static final DBService instance = DBService._privateConstructor();

  Database _database;

  static final String DB_NAME = "db_tasks.db";
  static final int DB_VERSION = 1;

  static final String TABLE_TASK = "tasks";
  static final String TASK_ID = "id";
  static final String TASK_TITLE = "title";
  static final String TASK_DESCRIPTION = "description";

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path_db = await getDatabasesPath();
    print("Caminho do DB $path_db");

    String path = join(path_db, DB_NAME);
    return await openDatabase(path,
        version: DB_VERSION, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int newVersion) async {
    List<String> query = [
      "CREATE TABLE $TABLE_TASK ($TASK_ID INTEGER PRIMARY KEY, $TASK_TITLE TEXT, $TASK_DESCRIPTION TEXT);"
    ];

    for (String qy in query) {
      await db.execute(qy);
    }
  }
}
