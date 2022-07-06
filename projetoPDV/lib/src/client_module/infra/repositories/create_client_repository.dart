abstract class ICreateClientRepository {
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName});
}
