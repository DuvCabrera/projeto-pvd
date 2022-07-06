abstract class IClientDatasource {
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName});

  Future<void> delete({required int id, required String tableName});

  Future<List<Map<String, dynamic>>> read({int? id, required String tableName});

  Future<void> update(
      {required int id,
      required Map<String, dynamic> data,
      required String tableName});
}
