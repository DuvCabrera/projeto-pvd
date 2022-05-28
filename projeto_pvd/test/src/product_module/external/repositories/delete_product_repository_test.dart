import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/product_module/external/external.dart';
import 'package:projeto_pvd/src/product_module/infra/repositories/repositories.dart';

import 'create_product_repository_test.mocks.dart';

class DeleteProductRepository extends IDeleteProductRepository {
  final IProductDatasource datasource;

  DeleteProductRepository(this.datasource);
  @override
  Future<void> delete({required int id, required String tableName}) async {
    try {
      await datasource.delete(tableName: tableName, id: id);
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}

void main() {
  late DeleteProductRepository sut;
  late IProductDatasource datasource;
  late String tableName;

  late int id;

  PostExpectation mockRepository() {
    return when(datasource.delete(tableName: tableName, id: id));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    id = 1;
    tableName = 'table';
    datasource = MockIProductDatasource();
    sut = DeleteProductRepository(datasource);
  });

  test('delete call the right paranms', () async {
    await sut.delete(tableName: tableName, id: id);
    verify(datasource.delete(tableName: tableName, id: id));
  });
  test('delete must thow externalerror.unexpected if throw', () {
    mockResponseThrow(Exception());
    final future = sut.delete(tableName: tableName, id: id);
    expect(future, throwsA(ExternalError.unexpected));
  });
}