import '../../comanda_module.dart';

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
