import 'package:flutter/material.dart';
import 'package:projeto_pvd/src/client_module/client_module.dart';
import 'package:provider/provider.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key, required this.bloc}) : super(key: key);
  final ClientBloc bloc;

  static create(BuildContext context) => ProxyProvider4<CreateClient,
          DeleteClient, ReadClient, UpdateClient, ClientBloc>(
        update: (context, create, delete, read, update, bloc) =>
            bloc ??
            ClientBloc(
                create: create, delete: delete, read: read, update: update),
        child: Consumer<ClientBloc>(
            builder: (context, bloc, child) => ClientPage(bloc: bloc)),
        dispose: (context, bloc) => bloc.dispose(),
      );

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = widget.bloc;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Clientes'),
      ),
      body: StreamBuilder(
        stream: _bloc.onNewSubject,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is LoadingClient) {
            return const CircularProgressIndicator();
          }
          if (state is SuccessClient) {
            final clientsList = state.clients;
            return Row(children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(children: [
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text('Buscar')),
                      onChanged: (text) {
                        _bloc.onSearchClient.add(text);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: clientsList.length,
                        itemBuilder: (context, index) => ListTile(
                          title: InkWell(
                            child: Text(
                                '${clientsList[index].name} ${clientsList[index].surName}'),
                            onTap: () async => showDialog(
                                context: context,
                                builder: (context) => ClientFormDialogWidget(
                                      client: clientsList[index],
                                      onUpdate: _bloc.onTryChangeClientList.add,
                                    )),
                          ),
                          leading: Text(clientsList[index].id.toString()),
                          subtitle: Text(clientsList[index].email),
                          trailing: IconButton(
                              onPressed: () => _bloc.onTryChangeClientList
                                  .add(RemoveClient(clientsList[index].id!)),
                              icon: const Icon(Icons.delete)),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) => ClientFormDialogWidget(
                                  client: null,
                                  onUpdate: _bloc.onTryChangeClientList.add,
                                )),
                        child: const Text('Adicione um Cliente'))
                  ])),
            ]);
          } else {
            return Center(
              child: ElevatedButton(
                  onPressed: () => _bloc.onTryNewSubject.add(null),
                  child: const Text('Tente Novamentes')),
            );
          }
        },
      ),
    );
  }
}
