import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/modules.dart';

import 'delete_product_test.mocks.dart';

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
