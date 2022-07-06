import '../../../core_module/core_module.dart';
import '../../domain/domain.dart';
import '../infra.dart';

class ReadClient extends IReadClient {
  final IReadClientRepository repository;
  final String tableName;

  ReadClient({required this.repository, required this.tableName});
  @override
  Future<List<Client>> read({int? id}) async {
    List<Map<String, dynamic>> clientsMapList = [];
    try {
      if (id != null) {
        clientsMapList = await repository.read(id: id, tableName: tableName);
      } else {
        clientsMapList = await repository.read(tableName: tableName);
      }
      final clientList =
          clientsMapList.map((e) => ClientModel.fromJson(e)).toList();
      return clientList;
    } on InfraError catch (e) {
      e == InfraError.invalidData
          ? throw InfraError.invalidData
          : throw InfraError.unexpected;
    } catch (e) {
      throw Exception(e);
    }
  }
}
