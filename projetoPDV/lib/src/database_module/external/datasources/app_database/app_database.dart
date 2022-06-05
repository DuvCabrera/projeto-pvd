import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Future<Database> initDb() async {
    final String path = join(await getDatabasesPath(), 'app.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await _createProductTable(db);
    });
  }
}

Future<void> _createProductTable(Database db) async {
  await db.execute('''CREATE TABLE product (
        id INTERGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        description TEXT,
      )''');
}
