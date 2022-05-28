abstract class IReadProductRepository {
  Future<List<Map<String, dynamic>>> read({int? id, required String tableName});
}
