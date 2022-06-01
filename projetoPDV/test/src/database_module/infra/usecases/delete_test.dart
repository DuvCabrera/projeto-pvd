import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/database_module.dart';

import 'create_test.mocks.dart';

void main() {
  late Delete sut;
  late int id;
  late String tableName;
  late IDatabaseRepository repository;

  PostExpectation mockRepository() {
    return when(repository.deleteData(id: id, tableName: tableName));
  }

  void mockFail(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    repository = MockIDatabaseRepository();
    sut = Delete(repository);
    id = 1;
    tableName = 'table';
  });
  test('delete should call right paranms', () async {
    await sut.delete(id: id, tableName: tableName);
    verify(repository.deleteData(id: id, tableName: tableName));
  });

  test('delete should throw databaseerror when throws', () {
    mockFail(Exception());
    final future = sut.delete(id: id, tableName: tableName);
    expect(future, throwsA(DatabaseError.unexpected));
  });
}
