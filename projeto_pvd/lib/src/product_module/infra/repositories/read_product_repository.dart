abstract class IReadProductRepository {
  Future<Map<String, dynamic>> readById(
      {required int id, required String tableName});
  Future<List<Map<String, dynamic>>> read();
}
