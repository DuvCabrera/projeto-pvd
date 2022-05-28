import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/product_module/external/external.dart';

import 'create_product_repository_test.mocks.dart';

void main() {
  late UpdateProductRepository sut;
  late IProductDatasource datasource;
  late String tableName;
  late Map<String, dynamic> data;
  late int id;

  PostExpectation mockRepository() {
    return when(datasource.update(data: data, tableName: tableName, id: id));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    id = 1;
    tableName = 'table';
    data = {};
    datasource = MockIProductDatasource();
    sut = UpdateProductRepository(datasource);
  });

  test('update call the right paranms', () async {
    await sut.update(data: data, tableName: tableName, id: id);
    verify(datasource.update(data: data, tableName: tableName, id: id));
  });
  test('create must thow externalerror.unexpected if throw', () {
    mockResponseThrow(Exception());
    final future = sut.update(data: data, tableName: tableName, id: id);
    expect(future, throwsA(ExternalError.unexpected));
  });
}
