import '../infra.dart';

abstract class IUpdateComandaRepository {
  Future<void> update(ComandaCM comanda);
}
