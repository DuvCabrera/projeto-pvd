import '../infra.dart';

abstract class ICreateComandaRepository {
  Future<void> create({required ComandaCM data});
}
