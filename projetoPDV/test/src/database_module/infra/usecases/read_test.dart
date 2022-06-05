import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/database_module.dart';

import 'create_test.mocks.dart';

void main() {
  late Read sut;
  late IDatabaseRepository repository;
  late String tableName;
  late int id;

  PostExpectation mockRepository() {
    return when(repository.readData(id: id, tableName: tableName));
  }

  void mockSuccess() {
    mockRepository()
        .thenAnswer((realInvocation) async => [<String, dynamic>{}]);
  }

  void mockFail(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    repository = MockIDatabaseRepository();
    sut = Read(repository);
    tableName = 'table';
    id = 1;
    mockSuccess();
  });
  test('read should call right paranms', () async {
    final result = await sut.read(tableName: tableName, id: id);
    expect(result, isA<List<Map<String, dynamic>>>());
  });

  test('should throw database error', () {});
  mockFail(Exception());

  final future = sut.read(tableName: tableName);
  expect(future, throwsA(DatabaseError.unexpected));
}
