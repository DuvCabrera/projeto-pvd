import '../../../core_module/core_module.dart';
import '../../infra/infra.dart';
import '../datasources/client_datasource.dart';

class CreateClientRepository extends ICreateClientRepository {
  final IClientDatasource datasource;

  CreateClientRepository(this.datasource);
  @override
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName}) async {
    try {
      await datasource.create(data: data, tableName: tableName);
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}
