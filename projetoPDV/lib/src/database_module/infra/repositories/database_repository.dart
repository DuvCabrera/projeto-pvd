abstract class IDatabaseRepository {
  Future<void> createData(
      {required Map<String, dynamic> data, required String tableName});

  Future<void> deleteData({required int id, required String tableName});

  Future<List<Map<String, dynamic>>> readData(
      {required String tableName, int? id});
  Future<void> updateData(
      {required String tableName,
      required int id,
      required Map<String, dynamic> data});
}
