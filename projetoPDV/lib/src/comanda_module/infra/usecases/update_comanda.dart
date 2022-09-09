import '../../domain/domain.dart';
import '../infra.dart';

class UpdateComanda extends IUpdateComanda {
  final IUpdateComandaRepository repository;

  UpdateComanda(this.repository);
  @override
  Future<void> updateComanda(Comanda comanda) async {
    try {
      await repository.update(ComandaCM.fromEntity(comanda));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
