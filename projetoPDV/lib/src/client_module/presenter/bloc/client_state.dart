import '../../domain/domain.dart';

abstract class ClientState {}

class LoadingClient extends ClientState {}

class SuccessClient extends ClientState {
  SuccessClient(this.clients);
  final List<Client> clients;
}

class ErrorClient extends ClientState {
  ErrorClient(this.message);
  final String message;
}
