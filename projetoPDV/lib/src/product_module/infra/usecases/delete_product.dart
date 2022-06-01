import '../../domain/domain.dart';
import '../infra.dart';

class DeleteProduct extends IDeleteProduct {
  final IDeleteProductRepository repository;
  final String tableName;

  DeleteProduct({required this.repository, required this.tableName});
  @override
  Future<void> deleteProduct(int id) async {
    try {
      await repository.delete(id: id, tableName: tableName);
    } catch (e) {
      throw InfraError.unexpected;
    }
  }
}
