import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'create_comanda_test.dart';
import 'read_comanda_test.mocks.dart';

class ReadComanda extends IReadComanda {
  final IReadComandaRepository repository;

  ReadComanda(this.repository);
  @override
  Future<List<Comanda>> readComanda() async {
    try {
      final result = await repository.readComandas();
      return result.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Comanda> readComandaById(int id) async {
    try {
      final result = await repository.readComandaById(id);
      return result.toEntity();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

abstract class IReadComandaRepository {
  Future<List<ComandaCM>> readComandas();
  Future<ComandaCM> readComandaById(int id);
}

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
