class Client {
  final int? id;
  final String name;
  final String surName;
  final String email;
  final String phone;
  final int cpf;
  final double wallet;
  final List<Map<String, dynamic>> history;

  Client(
      {this.id,
      required this.name,
      required this.surName,
      required this.email,
      required this.phone,
      required this.cpf,
      required this.wallet,
      required this.history});
}
