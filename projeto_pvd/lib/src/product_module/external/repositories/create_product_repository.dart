import '../../infra/infra.dart';
import '../external.dart';

class CreateProductRepository extends ICreateProductRepository {
  final IProductDatasource datasouce;

  CreateProductRepository(this.datasouce);
  @override
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName}) async {
    try {
      await datasouce.create(data: data, tableName: tableName);
    } on ExternalError catch (e) {
      e == ExternalError.invalidData
          ? ExternalError.invalidData
          : throw ExternalError.unexpected;
    } catch (e) {
      throw ExternalError.unexpected;
    }
  }
}
