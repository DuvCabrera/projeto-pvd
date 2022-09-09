import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'create_comanda_test.dart';
import 'update_comanda_test.mocks.dart';

class UpdateComanda extends IUpdateComanda {
  final IUpdateComandaRepository repository;

  UpdateComanda(this.repository);
  @override
  Future<void> updateComanda(Comanda comanda) async {
    try {
      await repository.update(ComandaCM.fromEntity(comanda));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

abstract class IUpdateComandaRepository {
  Future<void> update(ComandaCM comanda);
}

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
