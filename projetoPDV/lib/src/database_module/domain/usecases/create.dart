abstract class ICreate {
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName});
}
