abstract class IRead {
  Future<List<Map<String, dynamic>>> read({required String tableName, int? id});
}
