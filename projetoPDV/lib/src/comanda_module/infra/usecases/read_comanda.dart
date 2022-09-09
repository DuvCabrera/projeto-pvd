import '../../domain/domain.dart';
import '../infra.dart';

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
