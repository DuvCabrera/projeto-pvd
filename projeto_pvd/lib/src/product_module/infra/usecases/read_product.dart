import '../../domain/domain.dart';
import '../infra.dart';

class ReadProduct extends IReadProduct {
  final IReadProductRepository repository;
  final String tableName;

  ReadProduct({required this.repository, required this.tableName});
  @override
  Future<Product> readProductById(int id) async {
    try {
      final Map<String, dynamic> result =
          await repository.readById(id: id, tableName: tableName);
      return ProductModel.fromMap(result);
    } on InfraError catch (e) {
      e == InfraError.invalidData
          ? throw InfraError.invalidData
          : throw InfraError.unexpected;
    } catch (e) {
      throw InfraError.unexpected;
    }
  }

  @override
  Future<List<Product>> readProducts() async {
    try {
      final List<Map<String, dynamic>> response = await repository.read();
      List<Product> products = [];
      for (var map in response) {
        final Product product = ProductModel.fromMap(map);
        products.add(product);
      }
      return products;
    } on InfraError catch (e) {
      e == InfraError.invalidData
          ? throw InfraError.invalidData
          : throw InfraError.unexpected;
    } catch (e) {
      throw InfraError.unexpected;
    }
  }
}
