import '../../../core_module/core_module.dart';
import '../../domain/domain.dart';
import '../infra.dart';

class CreateClient extends ICreateClient {
  final ICreateClientRepository repository;
  final String tableName;

  CreateClient({required this.repository, required this.tableName});
  @override
  Future<void> create(Client entity) async {
    try {
      final Map<String, dynamic> data = ClientModel.fromEntity(entity).toMap();
      await repository.create(data: data, tableName: tableName);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
