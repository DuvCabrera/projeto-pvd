// import '../../domain/domain.dart';

import '../../domain/domain.dart';

abstract class ProductEvent {}

class AddProduct extends ProductEvent {
  AddProduct(this.product);

  final Product product;
}

class RemoveProduct extends ProductEvent {
  RemoveProduct(this.id);
  final int id;
}
