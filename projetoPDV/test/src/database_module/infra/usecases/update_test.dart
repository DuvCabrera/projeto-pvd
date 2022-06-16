import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/database_module.dart';

import 'create_test.mocks.dart';

void main() {
  late Update sut;
  late Map<String, dynamic> data;
  late int id;
  late String tableName;
  late IDatabaseRepository repository;

  PostExpectation mockRepository() {
    return when(
        repository.updateData(id: id, tableName: tableName, data: data));
  }

  void mockFail(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    repository = MockIDatabaseRepository();
    sut = Update(repository);
    id = 1;
    data = {};
    tableName = 'table';
  });

  test('delete should call right paranms', () async {
    await sut.update(id: id, tableName: tableName, data: data);
    verify(repository.updateData(id: id, tableName: tableName, data: data));
  });

  test('delete should throw databaseerror when throws', () {
    mockFail(Exception());
    final future = sut.update(id: id, tableName: tableName, data: data);
    expect(future, throwsA(DatabaseError.unexpected));
  });
}
