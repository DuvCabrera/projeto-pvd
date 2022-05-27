import '../../domain/domain.dart';

class ProductModel extends Product {
  ProductModel(
      {required int id,
      required String name,
      required double price,
      required String description})
      : super(id: id, name: name, price: price, description: description);
  factory ProductModel.fromEntity(Product entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        price: entity.price,
        description: entity.description,
      );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
