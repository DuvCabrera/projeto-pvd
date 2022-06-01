import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/database_module.dart';
import 'package:projeto_pvd/src/modules.dart';

import 'create_test.mocks.dart';

class Read extends IRead {
  final IDatabaseRepository repository;

  Read(this.repository);
  @override
  Future<List<Map<String, dynamic>>> read(
      {required String tableName, int? id}) async {
    try {
      final response = await repository.readData(tableName: tableName, id: id);
      return response;
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}

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
}
