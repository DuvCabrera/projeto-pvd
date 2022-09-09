import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'create_comanda_repository_test.dart';
import 'create_comanda_repository_test.mocks.dart';

class ReadComandaRepository extends IReadComandaRepository {
  final IComandaDatasouce datasouce;

  ReadComandaRepository(this.datasouce);
  @override
  Future<ComandaCM> readComandaById(int id) async {
    try {
      return await datasouce.readById(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ComandaCM>> readComandas() async {
    try {
      return await datasouce.read();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

void main() {
  late ReadComandaRepository sut;
  late IComandaDatasouce datasource;
  late int id;
  late ComandaCM data;

  PostExpectation mockRepository() {
    return when(datasource.readById(id));
  }

  PostExpectation mockRepositoryWithoutId() {
    return when(datasource.read());
  }

  void mockReponseByIdSuccessWithoutId() {
    mockRepositoryWithoutId().thenAnswer((realInvocation) async => [data]);
  }

  void mockReponseByIdSuccess() {
    mockRepository().thenAnswer((realInvocation) async => data);
  }

  void mockResponseInvalidData() {
    mockRepository().thenThrow(Exception());
  }

  setUp(() {
    id = 1;
    data = ComandaCM(
        id: '1',
        clientName: 'joje',
        products: [{}],
        initialTime: DateTime.now());
    datasource = MockIComandaDatasouce();
    sut = ReadComandaRepository(
      datasource,
    );
    mockReponseByIdSuccess();
    mockReponseByIdSuccessWithoutId();
  });

  test('readcomandabyid must return a comanda', () async {
    final result = await sut.readComandaById(id);
    expect(result, isA<ComandaCM>());
  });

  test('readComandas must return a list of comanda', () async {
    final result = await sut.readComandas();
    expect(result, isA<List<ComandaCM>>());
  });

  test('read throws Exception on error', () {
    mockResponseInvalidData();
    final future = sut.readComandas();
    expect(future, throwsA(isA<Exception>()));
  });

  test('readComandaByIs must throws an Exception', () {
    mockResponseInvalidData();
    final future = sut.readComandaById(id);
    expect(future, throwsA(isA<Exception>()));
  });
}
