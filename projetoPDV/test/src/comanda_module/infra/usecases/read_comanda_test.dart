import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'read_comanda_test.mocks.dart';

@GenerateMocks([IReadComandaRepository])
void main() {
  late ReadComanda sut;
  late IReadComandaRepository repository;
  late int id;
  late Comanda comanda;
  late ComandaCM data;

  PostExpectation mockRepository() {
    return when(repository.readComandaById(
      id,
    ));
  }

  PostExpectation mockRepository2() {
    return when(repository.readComandas());
  }

  void mockReponseByIdSuccess() {
    mockRepository().thenAnswer((realInvocation) async => data);
  }

  void mockResponseSucess() {
    mockRepository2().thenAnswer((realInvocation) async => [data]);
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  void mockResponseThrow2(error) {
    mockRepository2().thenThrow(error);
  }

  setUp(() {
    id = 1;

    comanda = Comanda(
        id: '1',
        clientName: 'joje',
        products: [{}],
        initialTime: DateTime.now());
    data = ComandaCM.fromEntity(comanda);
    repository = MockIReadComandaRepository();
    sut = ReadComanda(repository);
    mockReponseByIdSuccess();
    mockResponseSucess();
  });

  test('readbyid product must return a Product', () async {
    final product = await sut.readComandaById(id);
    expect(product, isA<Comanda>());
  });

  test('readbyid throws infraerror on exception', () {
    mockResponseThrow(Exception());
    final future = sut.readComandaById(id);
    expect(future, throwsA(isA<Exception>()));
  });

  test('readProducts must return a list of Product', () async {
    final product = await sut.readComanda();
    expect(product, isA<List<Comanda>>());
  });

  test('readProducts throws infraerror on exception', () {
    mockResponseThrow2(Exception());
    final future = sut.readComanda();
    expect(future, throwsA(isA<Exception>()));
  });
}
