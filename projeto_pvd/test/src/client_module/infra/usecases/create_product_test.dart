import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'create_product_test.mocks.dart';
import 'package:projeto_pvd/src/client_module/domain/domain.dart';

class CreateProduct extends ICreateProduct {
  final ICreateProductRepository repository;
  final String tableName;
  CreateProduct({required this.tableName, required this.repository});

  @override
  Future<void> createProduct(Product entity) async {
    try {
      final Map<String, dynamic> data = ProductModel.fromEntity(entity).toMap();
      await repository.create(data);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}

class ProductModel extends Product {
  ProductModel(
      {required int id,
      required String name,
      required double price,
      required String description})
      : super(id: id, name: name, price: price, description: description);
  factory ProductModel.fromEntity(Product entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        price: entity.price,
        description: entity.description,
      );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}

abstract class ICreateProductRepository {
  Future<void> create(Map<String, dynamic> data);
}

enum DomainError {
  unexpected,
}

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
