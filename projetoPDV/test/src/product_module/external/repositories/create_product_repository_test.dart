import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/product_module/external/external.dart';

import 'create_product_repository_test.mocks.dart';

@GenerateMocks([IProductDatasource])
void main() {
  late CreateProductRepository sut;
  late IProductDatasource datasource;
  late String tableName;
  late Map<String, dynamic> data;

  setUp(() {
    tableName = 'table';
    data = {};
    datasource = MockIProductDatasource();
    sut = CreateProductRepository(datasource);
  });

  PostExpectation mockRepository() {
    return when(datasource.create(data: data, tableName: tableName));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  test('create call the right paranms', () async {
    await sut.create(data: data, tableName: tableName);
    verify(datasource.create(data: data, tableName: tableName));
  });
  test('create must thow externalerror.unexpected if throw', () {
    mockResponseThrow(Exception());
    final future = sut.create(data: data, tableName: tableName);
    expect(future, throwsA(ExternalError.unexpected));
  });
}
