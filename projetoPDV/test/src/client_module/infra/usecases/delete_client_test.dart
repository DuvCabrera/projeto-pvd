import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:projeto_pvd/src/modules.dart';

import 'delete_client_test.mocks.dart';

@GenerateMocks([IDeleteClientRepository])
void main() {
  late DeleteClient sut;
  late IDeleteClientRepository repository;
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
    repository = MockIDeleteClientRepository();
    id = 1;
    sut = DeleteClient(tableName: tableName, repository: repository);
  });
  test('create must call the right params ', () async {
    await sut.delete(id);
    verify(repository.delete(id: id, tableName: tableName));
  });

  test('create must return DomainError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.delete(id);
    expect(future, throwsA(DomainError.unexpected));
  });
}
