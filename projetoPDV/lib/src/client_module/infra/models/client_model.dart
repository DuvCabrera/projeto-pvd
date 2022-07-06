import 'dart:convert';

import '../../../core_module/core_module.dart';
import '../../domain/domain.dart';

class ClientModel extends Client {
  ClientModel({
    super.id,
    required super.name,
    required super.surName,
    required super.email,
    required super.phone,
    required super.cpf,
    required super.wallet,
    required super.history,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('surName') || !json.containsKey('name')) {
      throw InfraError.invalidData;
    } else {
      return ClientModel(
          id: json['id'],
          name: json['name'],
          surName: json['surName'],
          email: json['email'],
          phone: json['phone'],
          cpf: json['cpf'],
          wallet: json['wallet'],
          history:
              List<Map<String, dynamic>>.from(jsonDecode(json['history'])));
    }
  }

  factory ClientModel.fromEntity(Client entity) => ClientModel(
      id: entity.id,
      name: entity.name,
      surName: entity.surName,
      email: entity.email,
      phone: entity.phone,
      cpf: entity.cpf,
      wallet: entity.wallet,
      history: entity.history);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surName': surName,
      'email': email,
      'phone': phone,
      'cpf': cpf,
      'wallet': wallet,
      'history': jsonEncode(history)
    };
  }
}
