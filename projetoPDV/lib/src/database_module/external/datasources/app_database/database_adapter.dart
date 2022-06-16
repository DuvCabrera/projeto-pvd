import 'package:projeto_pvd/src/database_module/database_module.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAdapter extends IDatabaseAdapter {
  final AppDatabase _appDatabase;

  DatabaseAdapter(this._appDatabase);
  @override
  Future<void> createData(
      {required Map<String, dynamic> data, required String tableName}) async {
    final Database db = await _appDatabase.initDb();
    if (tableName == 'product') {
      final existingRelation = await db.query(
        'product',
        where: 'id = ?',
        whereArgs: [data["id"]],
      );

      if (existingRelation.isEmpty) {
        await db.insert(tableName, data);
      } else {
        await db.update(
          tableName,
          data,
          where: "id = ?",
          whereArgs: [existingRelation.first['id']],
        );
      }

      return;
    }
    final alreadyExists = data["id"] != null
        ? await db.query(
            tableName,
            where: "id = ?",
            whereArgs: [data["id"] as int],
          )
        : [];

    if (alreadyExists.isNotEmpty) {
      await update(id: data["id"] as int, data: data, tableName: tableName);
    } else {
      await db.insert(tableName, data);
    }
  }

  @override
  Future<void> deleteData({required int id, required String tableName}) async {
    final Database db = await _appDatabase.initDb();
    await db.delete(
      tableName,
      where: ' id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> readData(
      {int? id, required String tableName}) async {
    final Database db = await _appDatabase.initDb();
    final result = await db.query(tableName);
    return result;
  }

  @override
  Future<void> update(
      {required int id,
      required String tableName,
      required Map<String, dynamic> data}) async {
    final Database db = await _appDatabase.initDb();
    await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
  }
}
