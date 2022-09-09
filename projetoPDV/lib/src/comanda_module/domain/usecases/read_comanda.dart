import '../entities/entities.dart';

abstract class IReadComanda {
  Future<List<Comanda>> readComanda();

  Future<Comanda> readComandaById(int id);
}
