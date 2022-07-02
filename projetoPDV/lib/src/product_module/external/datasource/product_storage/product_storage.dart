import '../../../../database_module/database_module.dart';
import '../../external.dart';

class ProductDatasource extends IProductDatasource {
  final IRead readData;
  final IDelete deleteData;
  final IUpdate updateData;
  final ICreate createData;

  ProductDatasource({
    required this.readData,
    required this.deleteData,
    required this.updateData,
    required this.createData,
  });
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
  Future<void> delete({required String tableName, required int id}) async {
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
      final result = await readData.read(tableName: tableName, id: id);
      return result;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> update(
      {required Map<String, dynamic> data,
      required String tableName,
      required int id}) async {
    try {
      await updateData.update(id: id, data: data, tableName: tableName);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }
}
