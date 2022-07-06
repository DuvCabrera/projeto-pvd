import '../entities/entities.dart';

abstract class IReadClient {
  Future<List<Client>> read({int? id});
}
