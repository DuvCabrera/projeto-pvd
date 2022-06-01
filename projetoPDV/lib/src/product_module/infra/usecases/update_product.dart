import '../../domain/domain.dart';
import '../infra.dart';

class UpdateProduct extends IUpdateProduct {
  final IUpdateProductRepository repository;
  final String tableName;

  UpdateProduct({required this.repository, required this.tableName});
  @override
  Future<void> updateProducts(
      {required int id, required Product entity}) async {
    try {
      final Map<String, dynamic> data = ProductModel.fromEntity(entity).toMap();
      await repository.update(id: id, data: data, tableName: tableName);
    } catch (e) {
      throw InfraError.unexpected;
    }
  }
}
