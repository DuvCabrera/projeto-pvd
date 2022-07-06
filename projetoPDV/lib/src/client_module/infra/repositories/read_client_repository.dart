abstract class IReadClientRepository {
  Future<List<Map<String, dynamic>>> read({int? id, required String tableName});
}
