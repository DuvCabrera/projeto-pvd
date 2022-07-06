import 'package:flutter/material.dart';

import '../../../product_module/presenter/widgets/custom_text_field.dart';
import '../../domain/domain.dart';
import '../bloc/bloc.dart';

class ClientFormDialogWidget extends StatefulWidget {
  const ClientFormDialogWidget({
    Key? key,
    required this.client,
    required this.onUpdate,
  }) : super(key: key);
  final Client? client;
  final Function(ClientEvent) onUpdate;

  @override
  State<ClientFormDialogWidget> createState() => _ClientFormDialogWidgetState();
}

class _ClientFormDialogWidgetState extends State<ClientFormDialogWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = '';
  double wallet = 0;
  String surName = '';
  int cpf = 0;
  String email = '';
  String phone = '';
  @override
  Widget build(BuildContext context) {
    final Client? _client = widget.client;
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Novo Produto'),
              const SizedBox(height: 15),
              CustomTextField(
                initialValue: _client == null ? '' : _client.name,
                label: 'Nome',
                onSave: (text) => name = text!,
                onValidate: (text) =>
                    (text == null || text.isEmpty) ? 'Preencha o campo' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                initialValue: _client == null ? '' : _client.surName,
                label: 'Sobrenome',
                onSave: (text) => surName = text!,
                onValidate: (text) =>
                    (text == null || text.isEmpty) ? 'Preencha o campo' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                initialValue: _client == null ? '' : _client.cpf.toString(),
                label: 'CPF',
                onSave: (text) => cpf = int.parse(text!),
                onValidate: (text) =>
                    (text == null || text.isEmpty) ? 'Preencha o campo' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                initialValue: _client == null ? '' : _client.email,
                label: 'E-Mail',
                onSave: (text) => email = text!,
                onValidate: (text) =>
                    (text == null || text.isEmpty) ? 'Preencha o campo' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                initialValue: _client == null ? '' : _client.phone,
                label: 'Telefone',
                onSave: (text) => phone = text!,
                onValidate: (text) =>
                    (text == null || text.isEmpty) ? 'Preencha o campo' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                initialValue: _client == null ? '' : _client.wallet.toString(),
                label: 'Carteira',
                onSave: (text) => wallet = double.parse(text!),
                onValidate: (text) =>
                    (text == null || text.isEmpty) ? 'Preencha o campo' : null,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                _client == null
                    ? widget.onUpdate(AddClient(Client(
                        id: null,
                        name: name,
                        cpf: cpf,
                        email: email,
                        history: [],
                        phone: phone,
                        surName: surName,
                        wallet: wallet,
                      )))
                    : widget.onUpdate(UpdateClients(Client(
                        id: _client.id,
                        name: name,
                        cpf: cpf,
                        email: email,
                        history: _client.history,
                        phone: phone,
                        surName: surName,
                        wallet: wallet,
                      )));
                Navigator.of(context).pop();
              }
            },
            child: _client == null
                ? const Text('Salvar')
                : const Text('Atualizar'))
      ],
    );
  }
}
