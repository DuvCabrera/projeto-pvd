import '../../../core_module/core_module.dart';
import '../../infra/infra.dart';
import '../datasources/client_datasource.dart';

class ReadClientRepository extends IReadClientRepository {
  final IClientDatasource datasource;

  ReadClientRepository(this.datasource);
  @override
  Future<List<Map<String, dynamic>>> read(
      {int? id, required String tableName}) async {
    try {
      final List<Map<String, dynamic>> result =
          await datasource.read(id: id, tableName: tableName);
      if (result[0].isEmpty) {
        throw ExternalError.invalidData;
      } else {
        return result;
      }
    } on ExternalError catch (e) {
      e == ExternalError.invalidData
          ? throw ExternalError.invalidData
          : throw ExternalError.unexpected;
    } catch (e) {
      throw Exception(e);
    }
  }
}
