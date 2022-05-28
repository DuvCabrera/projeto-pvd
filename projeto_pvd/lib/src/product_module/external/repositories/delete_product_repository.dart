import '../../infra/infra.dart';
import '../external.dart';

class DeleteProductRepository extends IDeleteProductRepository {
  final IProductDatasource datasource;

  DeleteProductRepository(this.datasource);
  @override
  Future<void> delete({required int id, required String tableName}) async {
    try {
      await datasource.delete(tableName: tableName, id: id);
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}
