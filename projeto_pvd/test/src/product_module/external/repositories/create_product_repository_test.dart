import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/product_module/infra/infra.dart';

import 'create_product_repository_test.mocks.dart';

class CreateProductRepository extends ICreateProductRepository {
  final IProductDatasource datasouce;

  CreateProductRepository(this.datasouce);
  @override
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName}) async {
    try {
      await datasouce.create(data: data, tableName: tableName);
    } on ExternalError catch (e) {
      e == ExternalError.invalidData
          ? ExternalError.invalidData
          : throw ExternalError.unexpected;
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}

abstract class IProductDatasource {
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName});
}

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

enum ExternalError {
  unexpected,
  invalidData,
}
