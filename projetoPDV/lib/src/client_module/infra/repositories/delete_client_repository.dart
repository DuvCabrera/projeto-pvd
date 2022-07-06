abstract class IDeleteClientRepository {
  Future<void> delete({required int id, required String tableName});
}
