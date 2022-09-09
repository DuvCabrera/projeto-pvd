import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'create_comanda_test.mocks.dart';

@GenerateMocks([ICreateComandaRepository])
void main() {
  late Comanda comanda;
  late CreateComanda sut;
  late ICreateComandaRepository repository;
  late ComandaCM data;

  PostExpectation mockRepository() {
    return when(repository.create(data: data));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    repository = MockICreateComandaRepository();
    comanda = Comanda(
        id: '1',
        clientName: 'joje',
        products: [{}],
        initialTime: DateTime.now());
    data = ComandaCM.fromEntity(comanda);
    sut = CreateComanda(repository: repository);
  });

  test('create must call the right params ', () async {
    await sut.createComanda(comanda);
    verify(repository.create(data: data));
  });

  test('create must return DomainError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.createComanda(comanda);
    expect(future, throwsA(isA<Exception>()));
  });
}
