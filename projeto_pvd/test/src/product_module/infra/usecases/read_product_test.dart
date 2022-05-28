import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/modules.dart';

import 'read_product_test.mocks.dart';

class ReadProduct extends IReadProduct {
  final IReadProductRepository repository;
  final String tableName;

  ReadProduct({required this.repository, required this.tableName});
  @override
  Future<Product> readProductById(int id) async {
    try {
      final Map<String, dynamic> result =
          await repository.readById(id: id, tableName: tableName);
      return ProductModel.fromMap(result);
    } on InfraError catch (e) {
      e == InfraError.invalidData
          ? throw InfraError.invalidData
          : throw InfraError.unexpected;
    } catch (e) {
      throw InfraError.unexpected;
    }
  }

  @override
  Future<List<Product>> readProducts() async {
    try {
      final List<Map<String, dynamic>> response = await repository.read();
      List<Product> products = [];
      for (var map in response) {
        final Product product = ProductModel.fromMap(map);
        products.add(product);
      }
      return products;
    } on InfraError catch (e) {
      e == InfraError.invalidData
          ? throw InfraError.invalidData
          : throw InfraError.unexpected;
    } catch (e) {
      throw InfraError.unexpected;
    }
  }
}

abstract class IReadProductRepository {
  Future<Map<String, dynamic>> readById(
      {required int id, required String tableName});
  Future<List<Map<String, dynamic>>> read();
}

@GenerateMocks([IReadProductRepository])
void main() {
  late ReadProduct sut;
  late String tableName;
  late IReadProductRepository repository;
  late int id;
  late Product product;

  PostExpectation mockRepository() {
    return when(repository.readById(id: id, tableName: tableName));
  }

  PostExpectation mockRepository2() {
    return when(repository.read());
  }

  void mockReponseByIdSuccess() {
    mockRepository().thenAnswer(
        (realInvocation) async => ProductModel.fromEntity(product).toMap());
  }

  void mockResponseSucess() {
    mockRepository2().thenAnswer(
        (realInvocation) async => [ProductModel.fromEntity(product).toMap()]);
  }

  void mockResponseInvalidData() {
    mockRepository().thenAnswer((realInvocation) async => <String, dynamic>{});
  }

  void mockResponseInvalidData2() {
    mockRepository2()
        .thenAnswer((realInvocation) async => [<String, dynamic>{}]);
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  void mockResponseThrow2(error) {
    mockRepository2().thenThrow(error);
  }

  setUp(() {
    id = 1;
    product = Product(
        id: id, name: 'bolo', price: 4.00, description: 'bolo com cobertura');
    tableName = 'table';
    repository = MockIReadProductRepository();
    sut = ReadProduct(repository: repository, tableName: tableName);
    mockReponseByIdSuccess();
    mockResponseSucess();
  });

  test('readbyid product must return a Product', () async {
    final product = await sut.readProductById(id);
    expect(product, isA<Product>());
  });

  test('readbyid throws infraerror on exception', () {
    mockResponseThrow(Exception);
    final future = sut.readProductById(id);
    expect(future, throwsA(InfraError.unexpected));
  });

  test('readbyid throws infraerror.invalidData on invalid data', () async {
    mockResponseInvalidData();
    final future = sut.readProductById(id);
    expect(future, throwsA(InfraError.invalidData));
  });

  test('readProducts must return a list of Product', () async {
    final product = await sut.readProducts();
    expect(product, isA<List<Product>>());
  });

  test('readProducts throws infraerror on exception', () {
    mockResponseThrow2(Exception);
    final future = sut.readProducts();
    expect(future, throwsA(InfraError.unexpected));
  });

  test('readProducts throws infraerror.invalidData on invalid data', () {
    mockResponseInvalidData2();
    final future = sut.readProducts();
    expect(future, throwsA(InfraError.invalidData));
  });
}
