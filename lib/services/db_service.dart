import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  DBService._privateConstructor();
  static final DBService instance = DBService._privateConstructor();

  Database _database;

  static final String DB_NAME = "db_tasks.db";
  static final int DB_VERSION = 3;

  static final String TABLE_TASK = "tasks";
  static final String TASK_ID = "id";
  static final String TASK_TITLE = "title";
  static final String TASK_DESCRIPTION = "description";
  static final String TASK_DONE = "done";

  static final String TABLE_IMAGE = "image";
  static final String IMAGE_ID = "id";
  static final String IMAGE_TASK_ID = "task_id";
  static final String IMAGE_BASE64 = "image_base64";

  static final String CREATE_TABLE_IMAGE =
      "CREATE TABLE $TABLE_IMAGE ($IMAGE_ID INTEGER PRIMARY KEY, $IMAGE_TASK_ID INTEGER, $IMAGE_BASE64 TEXT);";

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
        version: DB_VERSION,
        onCreate: _createDatabase,
        onUpgrade: _upgradeDatabase);
  }

  Future<void> _createDatabase(Database db, int newVersion) async {
    List<String> query = [
      "CREATE TABLE $TABLE_TASK ($TASK_ID INTEGER PRIMARY KEY, $TASK_TITLE TEXT, $TASK_DESCRIPTION TEXT, $TASK_DONE INTEGER DEFAULT 0);",
      "CREATE TABLE $TABLE_IMAGE ($IMAGE_ID INTEGER PRIMARY KEY, $IMAGE_TASK_ID INTEGER, $IMAGE_BASE64 TEXT);"
    ];

    for (String qy in query) {
      await db.execute(qy);
    }
  }

  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    List<String> query = [];

    if (oldVersion < 2) {
      query.add(
          "ALTER TABLE $TABLE_TASK ADD COLUMN $TASK_DONE INTEGER DEFAULT 0");
    }

    if (oldVersion < 3) {
      query.add(CREATE_TABLE_IMAGE);
    }

    for (String qy in query) {
      await db.execute(qy);
    }
  }
}
