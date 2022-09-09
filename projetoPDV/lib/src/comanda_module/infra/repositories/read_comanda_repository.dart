import '../../../modules.dart';

abstract class IReadComandaRepository {
  Future<List<ComandaCM>> readComandas();
  Future<ComandaCM> readComandaById(int id);
}
