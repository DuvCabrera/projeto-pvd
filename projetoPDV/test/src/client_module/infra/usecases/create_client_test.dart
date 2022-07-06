import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/client_module/domain/domain.dart';
import 'package:projeto_pvd/src/client_module/infra/infra.dart';
import 'package:projeto_pvd/src/core_module/core_module.dart';

import 'create_client_test.mocks.dart';

@GenerateMocks([ICreateClientRepository])
void main() {
  late Client client;
  late CreateClient sut;
  late ICreateClientRepository repository;
  late Map<String, dynamic> data;
  late String tableName;

  PostExpectation mockRepository() {
    return when(repository.create(data: data, tableName: tableName));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    tableName = 'produtos';
    repository = MockICreateClientRepository();
    client = Client(
        id: 1,
        name: 'bolo',
        surName: 'jonata',
        email: 'bolo com cobertura',
        phone: '3371',
        cpf: 1,
        wallet: 1,
        history: [{}]);
    data = ClientModel.fromEntity(client).toMap();
    sut = CreateClient(tableName: tableName, repository: repository);
  });
  test('create must call the right params ', () async {
    await sut.create(client);
    verify(repository.create(data: data, tableName: tableName));
  });

  test('create must return DomainError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.create(client);
    expect(future, throwsA(DomainError.unexpected));
  });
}
