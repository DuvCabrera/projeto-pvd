import '../domain.dart';

abstract class IUpdateProduct {
  Future<void> updateProducts({required int id, required Product entity});
}
