abstract class IRead {
  Future<Map<String, dynamic>> read({required String tableName, int? id});
}
