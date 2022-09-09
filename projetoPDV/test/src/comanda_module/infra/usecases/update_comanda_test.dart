import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'update_comanda_test.mocks.dart';

@GenerateMocks([IUpdateComandaRepository])
void main() {
  late Comanda comanda;
  late UpdateComanda sut;
  late IUpdateComandaRepository repository;
  late ComandaCM data;

  PostExpectation mockRepository() {
    return when(repository.update(data));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    repository = MockIUpdateComandaRepository();
    comanda = Comanda(
        id: '1',
        clientName: 'joje',
        products: [{}],
        initialTime: DateTime.now());
    data = ComandaCM.fromEntity(comanda);
    sut = UpdateComanda(repository);
  });
  test('update must call the right params d ', () async {
    await sut.updateComanda(comanda);
    verify(repository.update(data));
  });

  test('update must return InfraError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.updateComanda(comanda);
    expect(future, throwsA(isA<Exception>()));
  });
}
