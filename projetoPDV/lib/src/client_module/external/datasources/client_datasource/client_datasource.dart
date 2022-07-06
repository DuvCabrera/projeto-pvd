import '../../../../database_module/database_module.dart';
import '../client_datasource.dart';

class ClientDatasouce extends IClientDatasource {
  final ICreate createData;
  final IDelete deleteData;
  final IRead readData;
  final IUpdate updateData;

  ClientDatasouce(
      {required this.createData,
      required this.deleteData,
      required this.readData,
      required this.updateData});
  @override
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName}) async {
    try {
      await createData.create(data: data, tableName: tableName);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> delete({required int id, required String tableName}) async {
    try {
      await deleteData.delete(id: id, tableName: tableName);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> read(
      {int? id, required String tableName}) async {
    try {
      return await readData.read(tableName: tableName, id: id);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> update(
      {required int id,
      required Map<String, dynamic> data,
      required String tableName}) async {
    try {
      await updateData.update(id: id, data: data, tableName: tableName);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }
}
