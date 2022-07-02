import '../../domain/domain.dart';
import '../infra.dart';

class ReadProduct extends IReadProduct {
  final IReadProductRepository repository;
  final String tableName;

  ReadProduct({required this.repository, required this.tableName});
  @override
  Future<Product> readProductById(int id) async {
    try {
      final List<Map<String, dynamic>> result =
          await repository.read(id: id, tableName: tableName);
      final Map<String, dynamic> productMap = result
          .firstWhere((element) => element.containsValue(id), orElse: () => {});
      return ProductModel.fromMap(productMap);
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
      final List<Map<String, dynamic>> response =
          await repository.read(tableName: tableName);
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
      throw Exception();
    }
  }
}
