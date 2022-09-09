import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'create_comanda_repository_test.dart';
import 'create_comanda_repository_test.mocks.dart';

class UpdateComandaRepository extends IUpdateComandaRepository {
  final IComandaDatasouce datasouce;

  UpdateComandaRepository(this.datasouce);
  @override
  Future<void> update(ComandaCM data) async {
    try {
      await datasouce.update(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

void main() {
  late UpdateComandaRepository sut;
  late IComandaDatasouce datasource;

  late ComandaCM data;

  PostExpectation mockRepository() {
    return when(datasource.update(data));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    data = ComandaCM(
        id: '1',
        clientName: 'joje',
        products: [{}],
        initialTime: DateTime.now());
    datasource = MockIComandaDatasouce();
    sut = UpdateComandaRepository(datasource);
  });

  test('update call the right paranms', () async {
    await sut.update(data);
    verify(datasource.update(data));
  });
  test('create must thow externalerror.unexpected if throw', () {
    mockResponseThrow(Exception());
    final future = sut.update(data);
    expect(future, throwsA(isA<Exception>()));
  });
}
