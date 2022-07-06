import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/client_module/client_module.dart';
import 'package:projeto_pvd/src/core_module/core_module.dart';

import 'update_client_test.mocks.dart';

@GenerateMocks([IUpdateClientRepository])
void main() {
  late Client client;
  late UpdateClient sut;
  late IUpdateClientRepository repository;
  late Map<String, dynamic> data;
  late String tableName;
  late int id;

  PostExpectation mockRepository() {
    return when(repository.update(data: data, tableName: tableName, id: id));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    id = 1;
    tableName = 'produtos';
    repository = MockIUpdateClientRepository();
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
    sut = UpdateClient(tableName: tableName, repository: repository);
  });
  test('update must call the right params ', () async {
    await sut.update(id: id, entity: client);
    verify(repository.update(data: data, tableName: tableName, id: id));
  });

  test('update must return InfraError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.update(id: id, entity: client);
    expect(future, throwsA(InfraError.unexpected));
  });
}
