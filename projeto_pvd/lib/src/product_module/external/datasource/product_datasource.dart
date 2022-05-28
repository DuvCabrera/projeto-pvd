abstract class IProductDatasource {
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName});

  Future<void> update(
      {required Map<String, dynamic> data,
      required String tableName,
      required int id});
}// TODO Implement this library.