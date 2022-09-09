import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:projeto_pvd/src/modules.dart';

import 'delete_comanda_test.mocks.dart';

class DeleteComanda extends IDeleteComanda {
  final IDeleteComandaRepositoy repositoy;

  DeleteComanda(this.repositoy);
  @override
  Future<void> removeComanda(int id) async {
    try {
      await repositoy.delete(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

abstract class IDeleteComandaRepositoy {
  Future<void> delete(int id);
}

@GenerateMocks([IDeleteComandaRepositoy])
void main() {
  late DeleteComanda sut;
  late IDeleteComandaRepositoy repository;
  late int id;
  late String tableName;

  PostExpectation mockRepository() {
    return when(repository.delete(id));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  setUp(() {
    tableName = 'produtos';
    repository = MockIDeleteComandaRepositoy();
    id = 1;
    sut = DeleteComanda(repository);
  });
  test('create must call the right params ', () async {
    await sut.removeComanda(id);
    verify(repository.delete(id));
  });

  test('create must return DomainError.unspected when thows', () {
    mockResponseThrow(Exception());
    final future = sut.removeComanda(id);
    expect(future, throwsA(isA<Exception>()));
  });
}
