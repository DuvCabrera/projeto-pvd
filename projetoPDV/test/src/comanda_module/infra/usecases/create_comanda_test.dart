import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

import 'create_comanda_test.mocks.dart';

@HiveType(typeId: 0)
class ComandaCM {
  ComandaCM({
    required this.id,
    required this.clientName,
    required this.products,
    required this.initialTime,
  });

  factory ComandaCM.fromEntity(Comanda entity) => ComandaCM(
        id: entity.id,
        clientName: entity.clientName,
        products: entity.products,
        initialTime: entity.initialTime,
      );

  Comanda toEntity() => Comanda(
      id: id,
      clientName: clientName,
      products: products,
      initialTime: initialTime);

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String clientName;
  @HiveField(2)
  final List<Map<String, dynamic>> products;
  @HiveField(3)
  final DateTime initialTime;
}

class CreateComanda extends ICreateComanda {
  final ICreateComandaRepository repository;

  CreateComanda({required this.repository});
  @override
  Future<void> createComanda(Comanda comanda) async {
    try {
      final data = ComandaCM.fromEntity(comanda);
      await repository.create(data: data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

abstract class ICreateComandaRepository {
  Future<void> create({required ComandaCM data});
}

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
