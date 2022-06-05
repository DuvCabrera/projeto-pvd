abstract class IDatabaseAdapter {
  Future<void> createData({
    required Map<String, dynamic> data,
    required String tableName,
  });

  Future<List<Map<String, dynamic>>> readData({
    int? id,
    required String tableName,
  });

  Future<void> deleteData({required int id, required String tableName});

  Future<void> update(
      {required int id,
      required String tableName,
      required Map<String, dynamic> data});
}
