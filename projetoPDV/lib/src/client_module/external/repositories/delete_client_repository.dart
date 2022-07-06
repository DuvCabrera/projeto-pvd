import '../../../core_module/core_module.dart';
import '../../infra/infra.dart';
import '../datasources/client_datasource.dart';

class DeleteClientRepository extends IDeleteClientRepository {
  final IClientDatasource datasource;

  DeleteClientRepository(this.datasource);
  @override
  Future<void> delete({required int id, required String tableName}) async {
    try {
      await datasource.delete(id: id, tableName: tableName);
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}
