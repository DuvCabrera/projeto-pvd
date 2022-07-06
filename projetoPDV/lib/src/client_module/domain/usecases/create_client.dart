import '../entities/entities.dart';

abstract class ICreateClient {
  Future<void> create(Client entity);
}
