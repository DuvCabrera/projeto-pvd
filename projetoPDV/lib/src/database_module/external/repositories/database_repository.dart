import '../../domain/domain.dart';
import '../../infra/infra.dart';
import '../external.dart';

class DatabaseRepository extends IDatabaseRepository {
  final IDatabaseAdapter database;

  DatabaseRepository(this.database);
  @override
  Future<void> createData(
      {required Map<String, dynamic> data, required String tableName}) async {
    try {
      if (data.isEmpty || tableName.isEmpty) {
        throw DatabaseError.invalidData;
      }
      await database.createData(data: data, tableName: tableName);
    } on DatabaseError catch (e) {
      e == DatabaseError.invalidData
          ? throw DatabaseError.invalidData
          : throw DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> deleteData({required int id, required String tableName}) async {
    try {
      if (tableName.isEmpty) {
        throw DatabaseError.invalidData;
      }
      await database.deleteData(id: id, tableName: tableName);
    } on DatabaseError catch (e) {
      e == DatabaseError.invalidData
          ? throw DatabaseError.invalidData
          : throw DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> readData(
      {required String tableName, int? id}) async {
    try {
      if (tableName.isEmpty) {
        throw DatabaseError.invalidData;
      }
      return await database.readData(tableName: tableName, id: id);
    } on DatabaseError catch (e) {
      e == DatabaseError.invalidData
          ? throw DatabaseError.invalidData
          : throw DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> updateData(
      {required int id,
      required Map<String, dynamic> data,
      required String tableName}) async {
    try {
      if (data.isEmpty || tableName.isEmpty) {
        throw DatabaseError.invalidData;
      }
      await database.update(id: id, tableName: tableName, data: data);
    } on DatabaseError catch (e) {
      e == DatabaseError.invalidData
          ? throw DatabaseError.invalidData
          : DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }
}
