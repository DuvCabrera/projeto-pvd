import '../domain.dart';

abstract class ICreateProduct {
  Future<void> createProduct(Product entity);
}
