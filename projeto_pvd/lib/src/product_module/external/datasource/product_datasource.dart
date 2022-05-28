abstract class IProductDatasource {
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName});

  Future<void> update(
      {required Map<String, dynamic> data,
      required String tableName,
      required int id});

  Future<void> delete({required String tableName, required int id});

  Future<List<Map<String, dynamic>>> read({int? id, required String tableName});
}// TODO Implement this library.