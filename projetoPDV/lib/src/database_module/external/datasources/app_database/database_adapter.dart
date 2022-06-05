import 'package:projeto_pvd/src/database_module/database_module.dart';

class DatabaseAdapter extends IDatabaseAdapter {
  @override
  Future<void> createData(
      {required Map<String, dynamic> data, required String tableName}) {
    // TODO: implement createData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData({required int id, required String tableName}) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> readData(
      {int? id, required String tableName}) {
    // TODO: implement readData
    throw UnimplementedError();
  }

  @override
  Future<void> update(
      {required int id,
      required String tableName,
      required Map<String, dynamic> data}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
