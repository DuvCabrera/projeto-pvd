class Comanda {
  final String id;
  final String clientName;
  final List<Map<String, dynamic>> products;
  final DateTime initialTime;

  Comanda(
      {required this.id,
      required this.clientName,
      required this.products,
      required this.initialTime});
}
//produtos, horario, quantidade, nome do client

//product = {name: xxx, price: xxx, quantity: xxx}