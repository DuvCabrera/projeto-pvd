import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/modules.dart';

import 'delete_product_test.mocks.dart';

abstract class IDeleteProductRepository {
  Future<void> delete({required int id, required String tableName});
}

class DeleteProduct extends IDeleteProduct {
  final IDeleteProductRepository repository;
  final String tableName;

  DeleteProduct({required this.repository, required this.tableName});
  @override
  Future<void> deleteProduct(int id) async {
    try {
      await repository.delete(id: id, tableName: tableName);
    } catch (e) {
      throw InfraError.unexpected;
    }
  }
}

@GenerateMocks([IDeleteProductRepository])
void main() {
  late DeleteProduct sut;
  late IDeleteProductRepository repository;
  late int id;
  late String tableName;

  PostExpectation mockRepository() {
    return when(repository.delete(id: id, tableName: tableName));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    tableName = 'produtos';
    repository = MockIDeleteProductRepository();
    id = 1;
    sut = DeleteProduct(tableName: tableName, repository: repository);
  });
  test('create must call the right params ', () async {
    await sut.deleteProduct(id);
    verify(repository.delete(id: id, tableName: tableName));
  });

  test('create must return DomainError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.deleteProduct(id);
    expect(future, throwsA(InfraError.unexpected));
  });
}
