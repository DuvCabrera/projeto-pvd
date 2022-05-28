import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/modules.dart';

import 'create_product_repository_test.mocks.dart';

class ReadProductRepository extends IReadProductRepository {
  final IProductDatasource datasource;

  ReadProductRepository(this.datasource);
  @override
  Future<List<Map<String, dynamic>>> read(
      {int? id, required String tableName}) async {
    try {
      final List<Map<String, dynamic>> result =
          await datasource.read(tableName: tableName, id: id);
      for (var map in result) {
        if (map.isEmpty) throw ExternalError.invalidData;
      }
      return result;
    } on ExternalError catch (e) {
      e == ExternalError.invalidData
          ? throw ExternalError.invalidData
          : throw ExternalError.unexpected;
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}

void main() {
  late ReadProductRepository sut;
  late String tableName;
  late IProductDatasource datasource;
  late int id;
  late Product product;

  PostExpectation mockRepository() {
    return when(datasource.read(id: id, tableName: tableName));
  }

  PostExpectation mockRepositoryWithoutId() {
    return when(datasource.read(tableName: tableName));
  }

  void mockReponseByIdSuccessWithoutId() {
    mockRepositoryWithoutId().thenAnswer(
        (realInvocation) async => [ProductModel.fromEntity(product).toMap()]);
  }

  void mockReponseByIdSuccess() {
    mockRepository().thenAnswer(
        (realInvocation) async => [ProductModel.fromEntity(product).toMap()]);
  }

  void mockResponseInvalidData() {
    mockRepository()
        .thenAnswer((realInvocation) async => [<String, dynamic>{}]);
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    id = 1;
    product = Product(
        id: id, name: 'bolo', price: 4.00, description: 'bolo com cobertura');
    tableName = 'table';
    datasource = MockIProductDatasource();
    sut = ReadProductRepository(
      datasource,
    );
    mockReponseByIdSuccess();
    mockReponseByIdSuccessWithoutId();
  });

  test('read product must return a Product', () async {
    final product = await sut.read(id: id, tableName: tableName);
    expect(product, isA<List<Map<String, dynamic>>>());
  });

  test('read throws externalerror on exception', () {
    mockResponseThrow(Exception);
    final future = sut.read(id: id, tableName: tableName);
    expect(future, throwsA(ExternalError.unexpected));
  });

  test('read throws Externalerror.invalidData on invalid data', () async {
    mockResponseInvalidData();
    final future = sut.read(id: id, tableName: tableName);
    expect(future, throwsA(ExternalError.invalidData));
  });

  test('readProducts must return a list of Product', () async {
    final product = await sut.read(tableName: tableName);
    expect(product, isA<List<Map<String, dynamic>>>());
  });
}
