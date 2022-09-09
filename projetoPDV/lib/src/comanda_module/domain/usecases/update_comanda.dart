import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

abstract class IUpdateComanda {
  Future<void> updateComanda(Comanda comanda);
}
