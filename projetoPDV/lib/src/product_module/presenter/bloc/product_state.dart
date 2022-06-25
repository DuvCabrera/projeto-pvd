import 'package:projeto_pvd/src/modules.dart';

abstract class ProductState {}

class Success extends ProductState {
  final List<Product> product;

  Success(this.product);
}

class Error extends ProductState {}

class Loading extends ProductState {}
