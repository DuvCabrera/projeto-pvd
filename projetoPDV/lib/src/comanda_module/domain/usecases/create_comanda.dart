import 'package:projeto_pvd/src/comanda_module/comanda_module.dart';

abstract class ICreateComanda {
  Future<void> createComanda(Comanda comanda);
}
