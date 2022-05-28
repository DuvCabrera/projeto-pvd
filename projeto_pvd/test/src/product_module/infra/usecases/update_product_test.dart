import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/product_module/domain/domain.dart';
import 'package:projeto_pvd/src/product_module/infra/infra.dart';

import 'update_product_test.mocks.dart';

abstract class IUpdateProductRepository {
  Future<void> update({
    required int id,
    required Map<String, dynamic> data,
    required String tableName,
  });
}

class UpdateProduct extends IUpdateProduct {
  final IUpdateProductRepository repository;
  final String tableName;

  UpdateProduct({required this.repository, required this.tableName});
  @override
  Future<void> updateProducts(
      {required int id, required Product entity}) async {
    try {
      final Map<String, dynamic> data = ProductModel.fromEntity(entity).toMap();
      await repository.update(id: id, data: data, tableName: tableName);
    } catch (e) {
      throw InfraError.unexpected;
    }
  }
}

@GenerateMocks([IUpdateProductRepository])
void main() {
  late Product product;
  late UpdateProduct sut;
  late IUpdateProductRepository repository;
  late Map<String, dynamic> data;
  late String tableName;
  late int id;

  PostExpectation mockRepository() {
    return when(repository.update(data: data, tableName: tableName, id: id));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    id = 1;
    tableName = 'produtos';
    repository = MockIUpdateProductRepository();
    product = Product(
        id: 1, name: 'bolo', price: 4.00, description: 'bolo com cobertura');
    data = ProductModel.fromEntity(product).toMap();
    sut = UpdateProduct(tableName: tableName, repository: repository);
  });
  test('update must call the right params ', () async {
    await sut.updateProducts(id: id, entity: product);
    verify(repository.update(data: data, tableName: tableName, id: id));
  });

  test('update must return InfraError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.updateProducts(id: id, entity: product);
    expect(future, throwsA(InfraError.unexpected));
  });
}
