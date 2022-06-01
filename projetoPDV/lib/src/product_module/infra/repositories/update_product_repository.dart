abstract class IUpdateProductRepository {
  Future<void> update({
    required int id,
    required Map<String, dynamic> data,
    required String tableName,
  });
}
