import '../../../modules.dart';

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
