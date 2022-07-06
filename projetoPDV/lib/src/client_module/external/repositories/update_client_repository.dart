import '../../../core_module/core_module.dart';
import '../../infra/infra.dart';
import '../datasources/client_datasource.dart';

class UpdateClientRepository extends IUpdateClientRepository {
  final IClientDatasource datasource;

  UpdateClientRepository(this.datasource);
  @override
  Future<void> update(
      {required int id,
      required Map<String, dynamic> data,
      required String tableName}) async {
    try {
      await datasource.update(id: id, data: data, tableName: tableName);
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}
