import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/database_module.dart';

import 'create_test.mocks.dart';

void main() {
  late Update sut;
  late IDatabaseRepository repository;
  late Map<String, dynamic> data;
  late int id;
  late String tableName;

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
    data = {};
    id = 1;
    tableName = 'table';
  });
  test('update must call the right paranms', () async {
    await sut.update(id: id, data: data, tableName: tableName);
    verify(repository.updateData(id: id, data: data, tableName: tableName));
  });

  test('should throw database error if throws', () {
    mockFail(Exception());
    final future = sut.update(id: id, data: data, tableName: tableName);
    expect(future, throwsA(DatabaseError.unexpected));
  });
}
