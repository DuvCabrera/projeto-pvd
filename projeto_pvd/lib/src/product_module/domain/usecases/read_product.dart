import '../domain.dart';

abstract class IReadProduct {
  Future<Product> readProductById(int id);

  Future<List<Product>> readProducts();
}
