import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/domain/domain.dart';
import 'package:projeto_pvd/src/database_module/infra/infra.dart';

import 'create_test.mocks.dart';


@GenerateMocks([IDatabaseRepository])
void main() {
  late Create sut;
  late Map<String, dynamic> data;
  late String tableName;
  late IDatabaseRepository repository;

  PostExpectation mockRepository() {
    return when(repository.createData(data: data, tableName: tableName));
  }

  void mockFail(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    repository = MockIDatabaseRepository();
    sut = Create(repository);
    data = {};
    tableName = 'table';
  });
  test('create should call the right paranms', () async {
    await sut.create(data: data, tableName: tableName);
    verify(repository.createData(data: data, tableName: tableName));
  });

  test('create should throw when throw', () async {
    mockFail(DatabaseError.unexpected);
    final future = sut.create(data: data, tableName: tableName);
    expect(future, throwsA(DatabaseError.unexpected));
  });
}

