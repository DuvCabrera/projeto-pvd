abstract class IDeleteProductRepository {
  Future<void> delete({required int id, required String tableName});
}
