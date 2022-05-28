import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/product_module/external/external.dart';

import 'create_product_repository_test.mocks.dart';

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
