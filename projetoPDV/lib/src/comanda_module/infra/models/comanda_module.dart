import 'package:hive/hive.dart';

import '../../comanda_module.dart';

@HiveType(typeId: 0)
class ComandaCM {
  ComandaCM({
    required this.id,
    required this.clientName,
    required this.products,
    required this.initialTime,
  });

  factory ComandaCM.fromEntity(Comanda entity) => ComandaCM(
        id: entity.id,
        clientName: entity.clientName,
        products: entity.products,
        initialTime: entity.initialTime,
      );

  Comanda toEntity() => Comanda(
      id: id,
      clientName: clientName,
      products: products,
      initialTime: initialTime);

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String clientName;
  @HiveField(2)
  final List<Map<String, dynamic>> products;
  @HiveField(3)
  final DateTime initialTime;
}
