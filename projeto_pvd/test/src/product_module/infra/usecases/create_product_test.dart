import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/product_module/domain/domain.dart';
import 'package:projeto_pvd/src/product_module/infra/infra.dart';

import 'create_product_test.mocks.dart';

@GenerateMocks([ICreateProductRepository])
void main() {
  late Product product;
  late CreateProduct sut;
  late ICreateProductRepository repository;
  late Map<String, dynamic> data;
  late String tableName;

  PostExpectation mockRepository() {
    return when(repository.create(data));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    tableName = 'produtos';
    repository = MockICreateProductRepository();
    product = Product(
        id: 1, name: 'bolo', price: 4.00, description: 'bolo com cobertura');
    data = ProductModel.fromEntity(product).toMap();
    sut = CreateProduct(tableName: tableName, repository: repository);
  });
  test('create must call the right params ', () async {
    await sut.createProduct(product);
    verify(repository.create(data));
  });

  test('create must return DomainError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.createProduct(product);
    expect(future, throwsA(DomainError.unexpected));
  });
}
