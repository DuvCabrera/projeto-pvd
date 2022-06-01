import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_pvd/src/product_module/external/external.dart';

class ProductDatasource extends IProductDatasource {
  @override
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String tableName, required int id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> read(
      {int? id, required String tableName}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> update(
      {required Map<String, dynamic> data,
      required String tableName,
      required int id}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

void main() {
  test('product storage ...', () async {
    // TODO: Implement test
  });
}
