import '../domain.dart';

abstract class IUpdateProduct {
  Future<void> updateProducts(int id, Product entity);
}
