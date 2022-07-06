import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/client_module/domain/domain.dart';
import 'package:projeto_pvd/src/client_module/external/datasources/client_datasource.dart';
import 'package:projeto_pvd/src/client_module/external/external.dart';
import 'package:projeto_pvd/src/client_module/infra/infra.dart';
import 'package:projeto_pvd/src/core_module/core_module.dart';

import 'create_client_repository_test.mocks.dart';

void main() {
  late ReadClientRepository sut;
  late String tableName;
  late IClientDatasource datasource;
  late int id;
  late Client client;

  PostExpectation mockRepository() {
    return when(datasource.read(id: id, tableName: tableName));
  }

  PostExpectation mockRepositoryWithoutId() {
    return when(datasource.read(tableName: tableName));
  }

  void mockReponseByIdSuccessWithoutId() {
    mockRepositoryWithoutId().thenAnswer(
        (realInvocation) async => [ClientModel.fromEntity(client).toMap()]);
  }

  void mockReponseByIdSuccess() {
    mockRepository().thenAnswer(
        (realInvocation) async => [ClientModel.fromEntity(client).toMap()]);
  }

  void mockResponseInvalidData() {
    mockRepository()
        .thenAnswer((realInvocation) async => [<String, dynamic>{}]);
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
        history: [{}]);
    tableName = 'table';
    datasource = MockIClientDatasource();
    sut = ReadClientRepository(
      datasource,
    );
    mockReponseByIdSuccess();
    mockReponseByIdSuccessWithoutId();
  });

  test('read product must return a Product', () async {
    final product = await sut.read(id: id, tableName: tableName);
    expect(product, isA<List<Map<String, dynamic>>>());
  });

  test('read throws Externalerror.invalidData on invalid data', () async {
    mockResponseInvalidData();
    final future = sut.read(id: id, tableName: tableName);
    expect(future, throwsA(ExternalError.invalidData));
  });

  test('readProducts must return a list of Product', () async {
    final product = await sut.read(tableName: tableName);
    expect(product, isA<List<Map<String, dynamic>>>());
  });
}
