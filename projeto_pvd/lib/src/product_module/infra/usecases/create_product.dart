import '../../domain/domain.dart';
import '../infra.dart';

class CreateProduct extends ICreateProduct {
  final ICreateProductRepository repository;
  final String tableName;
  CreateProduct({required this.tableName, required this.repository});

  @override
  Future<void> createProduct(Product entity) async {
    try {
      final Map<String, dynamic> data = ProductModel.fromEntity(entity).toMap();
      await repository.create(data: data, tableName: tableName);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
