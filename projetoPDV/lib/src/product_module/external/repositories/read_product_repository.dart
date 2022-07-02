import '../../infra/infra.dart';
import '../external.dart';

class ReadProductRepository extends IReadProductRepository {
  final IProductDatasource datasource;

  ReadProductRepository(this.datasource);
  @override
  Future<List<Map<String, dynamic>>> read(
      {int? id, required String tableName}) async {
    try {
      final List<Map<String, dynamic>> result =
          await datasource.read(tableName: tableName, id: id);
      for (var map in result) {
        if (map.isEmpty) throw ExternalError.invalidData;
      }
      return result;
    } on ExternalError catch (e) {
      e == ExternalError.invalidData
          ? throw ExternalError.invalidData
          : throw ExternalError.unexpected;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
