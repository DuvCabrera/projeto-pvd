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
              await _createClientTable(db);
              await _createProductTable(db);
            },
            onDowngrade: onDatabaseDowngradeDelete));
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

Future<void> _createClientTable(Database db) async {
  await db.execute('''CREATE TABLE client (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    surName TEXT,
    email TEXT,
    phone TEXT,
    cpf INTEGER,
    wallet REAL,
    history TEXT
  );
''');
}
