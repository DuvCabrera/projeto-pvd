import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/infra/infra.dart';

import 'create_comanda_repository_test.mocks.dart';

abstract class IComandaDatasouce {
  Future<void> create(ComandaCM data);
  Future<void> delete(int id);
  Future<void> update(ComandaCM data);
  Future<List<ComandaCM>> read();
  Future<ComandaCM> readById(int id);
}

class CreateComandaRepository extends ICreateComandaRepository {
  final IComandaDatasouce datasource;

  CreateComandaRepository(this.datasource);
  @override
  Future<void> create({required ComandaCM data}) async {
    try {
      await datasource.create(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

@GenerateMocks([IComandaDatasouce])
void main() {
  late CreateComandaRepository sut;
  late IComandaDatasouce datasource;
  late ComandaCM data;

  setUp(() {
    data = ComandaCM(
        id: '1',
        clientName: 'joje',
        products: [{}],
        initialTime: DateTime.now());

    datasource = MockIComandaDatasouce();
    sut = CreateComandaRepository(datasource);
  });

  PostExpectation mockRepository() {
    return when(datasource.create(data));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  test('create call the right paranms', () async {
    await sut.create(data: data);
    verify(datasource.create(data));
  });
  test('create must thow externalerror.unexpected if throw', () {
    mockResponseThrow(Exception());
    final future = sut.create(data: data);
    expect(future, throwsA(isA<Exception>()));
  });
}
