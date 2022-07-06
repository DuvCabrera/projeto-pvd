import '../../../core_module/core_module.dart';
import '../../domain/domain.dart';
import '../infra.dart';

class UpdateClient extends IUpdateClient {
  final IUpdateClientRepository repository;
  final String tableName;

  UpdateClient({required this.repository, required this.tableName});
  @override
  Future<void> update({required int id, required Client entity}) async {
    try {
      final Map<String, dynamic> data = ClientModel.fromEntity(entity).toMap();
      await repository.update(id: id, data: data, tableName: tableName);
    } catch (e) {
      throw InfraError.unexpected;
    }
  }
}
