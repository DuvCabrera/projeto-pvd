import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../bloc/product_event.dart';
import 'custom_text_field.dart';

class FormDialogWidget extends StatefulWidget {
  const FormDialogWidget(
      {Key? key, required this.product, required this.onUpdate})
      : super(key: key);
  final Product product;
  final Function(ProductEvent) onUpdate;
  @override
  State<FormDialogWidget> createState() => _FormDialogWidgetState();
}

class _FormDialogWidgetState extends State<FormDialogWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = '';
  double price = 0;
  String description = '';
  @override
  Widget build(BuildContext context) {
    final Product _product = widget.product;
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
                initialValue: _product.name,
                label: 'Nome',
                onSave: (text) => name = text!,
                onValidate: (text) =>
                    (text == null || text.isEmpty) ? 'Preencha o campo' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                initialValue: _product.price.toString(),
                label: 'Preço',
                onSave: (text) => price = double.parse(text!),
                onValidate: (text) =>
                    (text == null || text.isEmpty) ? 'Preencha o campo' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                initialValue: _product.description,
                label: 'Descrição',
                onSave: (text) => description = text!,
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
                widget.onUpdate(UpdateProducts(Product(
                    id: _product.id,
                    name: name,
                    price: price,
                    description: description)));
              }
              Navigator.of(context).pop();
            },
            child: const Text('Salvar'))
      ],
    );
  }
}
