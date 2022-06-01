import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/domain/domain.dart';

import 'create_test.mocks.dart';

class Create extends ICreate {
  final IDatabaseRepository repository;

  Create(this.repository);
  @override
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName}) async {
    await repository.createData(data: data, tableName: tableName);
  }
}

abstract class IDatabaseRepository {
  Future<void> createData(
      {required Map<String, dynamic> data, required String tableName});
}

@GenerateMocks([IDatabaseRepository])
void main() {
  late Create sut;
  late Map<String, dynamic> data;
  late String tableName;
  late IDatabaseRepository repository;

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
}
