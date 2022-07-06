import 'package:projeto_pvd/src/client_module/client_module.dart';
import 'package:rxdart/rxdart.dart';

class ClientBloc {
  ClientBloc(
      {required this.create,
      required this.delete,
      required this.read,
      required this.update}) {
    _subscriptions
      ..add(Rx.merge(<Stream>[Stream.value(null), _onTryNewSubject])
          .flatMap((_) => _fetchClientList())
          .listen(_clientSubject.add))
      ..add(_onTryChangeClientList
          .flatMap((event) => _changeClientList(event))
          .listen(_clientSubject.add))
      ..add(_onSearchClient
          .flatMap((value) => _searchProducts(value))
          .listen(_clientSubject.add));
    ;
  }

  final ICreateClient create;
  final IDeleteClient delete;
  final IReadClient read;
  final IUpdateClient update;

  final _subscriptions = CompositeSubscription();

  final _clientSubject = BehaviorSubject<ClientState>();
  Stream<ClientState> get onNewSubject => _clientSubject.stream;

  final _onTryNewSubject = PublishSubject<void>();
  Sink<void> get onTryNewSubject => _onTryNewSubject.sink;

  final _onTryChangeClientList = PublishSubject<ClientEvent>();
  Sink<ClientEvent> get onTryChangeClientList => _onTryChangeClientList.sink;

  final _onSearchClient = PublishSubject<String>();
  Sink<String> get onSearchClient => _onSearchClient.sink;

  Stream<ClientState> _fetchClientList() async* {
    yield LoadingClient();
    try {
      yield SuccessClient(await read.read());
    } catch (e) {
      yield ErrorClient(e.toString());
    }
  }

  Stream<ClientState> _changeClientList(ClientEvent event) async* {
    try {
      if (event is AddClient) {
        await create.create(event.client);
      } else if (event is RemoveClient) {
        await delete.delete(event.id);
      } else if (event is UpdateClients) {
        await update.update(id: event.client.id!, entity: event.client);
      }
      yield SuccessClient(await read.read());
    } catch (e) {
      yield ErrorClient(e.toString());
    }
  }

  Stream<ClientState> _searchProducts(String value) async* {
    ClientState state = _clientSubject.value;
    List<Client> newList = [];
    if (state is LoadingClient) {
      yield LoadingClient();
    } else if (state is SuccessClient) {
      if (value.isEmpty) {
        onTryNewSubject.add(null);
      } else {
        newList = state.clients
            .where((element) => element.name.contains(value))
            .toList();
        yield SuccessClient(newList);
      }
    }
  }

  void dispose() {
    _subscriptions.dispose();
    _clientSubject.close();
    _onTryChangeClientList.close();
    _onTryNewSubject.close();
  }
}
