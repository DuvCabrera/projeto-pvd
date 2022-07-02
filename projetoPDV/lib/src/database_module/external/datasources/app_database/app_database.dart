import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppDatabase {
  Future<Database> initDb() async {
    sqfliteFfiInit();
    final String appPath = await databaseFactoryFfi.getDatabasesPath();
    final String path = join(appPath, 'app.db');

    DatabaseFactory databaseFactory = databaseFactoryFfi;

    return databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, newerVersion) async {
              await _createProductTable(db);
            }));
  }
}

Future<void> _createProductTable(Database db) async {
  await db.execute('''CREATE TABLE product (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        description TEXT
      );''');
}
