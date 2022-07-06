import '../../../core_module/core_module.dart';
import '../../domain/domain.dart';
import '../infra.dart';

class DeleteClient extends IDeleteClient {
  final IDeleteClientRepository repository;
  final String tableName;

  DeleteClient({required this.repository, required this.tableName});
  @override
  Future<void> delete(int id) async {
    try {
      await repository.delete(id: id, tableName: tableName);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
