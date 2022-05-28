import '../../infra/infra.dart';
import '../external.dart';

class UpdateProductRepository extends IUpdateProductRepository {
  final IProductDatasource datasource;

  UpdateProductRepository(this.datasource);

  @override
  Future<void> update(
      {required int id,
      required Map<String, dynamic> data,
      required String tableName}) async {
    try {
      await datasource.update(data: data, tableName: tableName, id: id);
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}
