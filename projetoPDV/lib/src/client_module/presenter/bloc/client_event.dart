import '../../domain/domain.dart';

abstract class ClientEvent {}

class AddClient extends ClientEvent {
  AddClient(this.client);
  final Client client;
}

class RemoveClient extends ClientEvent {
  RemoveClient(this.id);
  final int id;
}

class UpdateClients extends ClientEvent {
  UpdateClients(this.client);
  final Client client;
}
