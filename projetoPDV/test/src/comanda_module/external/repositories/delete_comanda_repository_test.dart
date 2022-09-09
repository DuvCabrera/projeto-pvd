import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'create_comanda_repository_test.dart';
import 'create_comanda_repository_test.mocks.dart';

class DeleteComandaRepository extends IDeleteComandaRepositoy {
  final IComandaDatasouce datasource;

  DeleteComandaRepository(this.datasource);
  @override
  Future<void> delete(int id) async {
    try {
      await datasource.delete(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

void main() {
  late DeleteComandaRepository sut;
  late IComandaDatasouce datasource;
  late int id;

  PostExpectation mockRepository() {
    return when(datasource.delete(id));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    id = 1;
    datasource = MockIComandaDatasouce();
    sut = DeleteComandaRepository(datasource);
  });

  test('delete call the right paranms', () async {
    await sut.delete(id);
    verify(datasource.delete(id));
  });
  test('delete must thow externalerror.unexpected if throw', () {
    mockResponseThrow(Exception());
    final future = sut.delete(id);
    expect(future, throwsA(isA<Exception>()));
  });
}
