import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/client_module/domain/domain.dart';
import 'package:projeto_pvd/src/client_module/infra/infra.dart';
import 'package:projeto_pvd/src/core_module/core_module.dart';

import 'read_client_test.mocks.dart';

@GenerateMocks([IReadClientRepository])
void main() {
  late ReadClient sut;
  late String tableName;
  late IReadClientRepository repository;
  late int id;
  late Client client;

  PostExpectation mockRepository() {
    return when(repository.read(id: id, tableName: tableName));
  }

  PostExpectation mockRepository2() {
    return when(repository.read(tableName: tableName));
  }

  void mockReponseByIdSuccess() {
    mockRepository().thenAnswer(
        (realInvocation) async => [ClientModel.fromEntity(client).toMap()]);
  }

  void mockResponseSucess() {
    mockRepository2().thenAnswer(
        (realInvocation) async => [ClientModel.fromEntity(client).toMap()]);
  }

  void mockResponseInvalidData() {
    mockRepository()
        .thenAnswer((realInvocation) async => [<String, dynamic>{}]);
  }

  void mockResponseInvalidData2() {
    mockRepository2()
        .thenAnswer((realInvocation) async => [<String, dynamic>{}]);
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  void mockResponseThrow2(error) {
    mockRepository2().thenThrow(error);
  }

  setUp(() {
    id = 1;

    client = Client(
        id: 1,
        name: 'bolo',
        surName: 'jonata',
        email: 'bolo com cobertura',
        phone: '3371',
        cpf: 1,
        wallet: 1,
        history: [
          {'ss': 2},
          {'ww': 2}
        ]);
    tableName = 'table';
    repository = MockIReadClientRepository();
    sut = ReadClient(repository: repository, tableName: tableName);
    mockReponseByIdSuccess();
    mockResponseSucess();
  });

  test('readbyid product must return a Product', () async {
    final product = await sut.read(id: id);
    expect(product, isA<List<Client>>());
  });

  test('readbyid throws infraerror on exception', () {
    mockResponseThrow(InfraError.unexpected);
    final future = sut.read(id: id);
    expect(future, throwsA(InfraError.unexpected));
  });

  test('readbyid throws infraerror.invalidData on invalid data', () async {
    mockResponseInvalidData();
    final future = sut.read(id: id);
    expect(future, throwsA(InfraError.invalidData));
  });

  test('readProducts must return a list of Product', () async {
    final product = await sut.read();
    expect(product, isA<List<Client>>());
  });

  test('readProducts throws infraerror on exception', () {
    mockResponseThrow2(InfraError.unexpected);
    final future = sut.read();
    expect(future, throwsA(InfraError.unexpected));
  });

  test('readProducts throws infraerror.invalidData on invalid data', () {
    mockResponseInvalidData2();
    final future = sut.read();
    expect(future, throwsA(InfraError.invalidData));
  });
}
