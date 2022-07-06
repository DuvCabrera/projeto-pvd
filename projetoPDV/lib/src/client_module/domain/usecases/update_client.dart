import '../entities/entities.dart';

abstract class IUpdateClient {
  Future<void> update({required int id, required Client entity});
}
