import '../../domain/domain.dart';
import '../helpers/helpers.dart';

class ProductModel extends Product {
  ProductModel(
      {required int? id,
      required String name,
      required double price,
      required String description})
      : super(id: id, name: name, price: price, description: description);

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('id') || !map.containsKey('name')) {
      throw InfraError.invalidData;
    } else {
      return ProductModel(
          id: map['id'],
          name: map['name'],
          price: map['price'],
          description: map['description']);
    }
  }

  factory ProductModel.fromEntity(Product entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        price: entity.price,
        description: entity.description,
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
