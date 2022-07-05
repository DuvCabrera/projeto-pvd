import 'package:flutter/material.dart';
import 'package:projeto_pvd/src/modules.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_field.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.bloc}) : super(key: key);

  final ProductBloc bloc;

  static Widget create(BuildContext context) => ProxyProvider4<UpdateProduct,
          ReadProduct, DeleteProduct, CreateProduct, ProductBloc>(
        update: (_, update, read, delete, create, productBloc) =>
            productBloc ?? ProductBloc(create, delete, read, update),
        child: Consumer<ProductBloc>(
            builder: (context, bloc, child) => ProductPage(bloc: bloc)),
        dispose: (context, bloc) => bloc.dispose(),
      );

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _bloc = widget.bloc;
    String name = "";
    String description = '';
    double price = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina de Produtos'),
      ),
      body: StreamBuilder(
        stream: _bloc.onNewSubject,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is Loading) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data is Success) {
              bool showAddProductFormulary = false;
              final productList = snapshot.data as Success;
              return Row(children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(children: [
                      TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Buscar')),
                        onChanged: (text) {
                          _bloc.onSearchProduct.add(text);
                          print(text);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: productList.product.length,
                          itemBuilder: (context, index) => ListTile(
                            title: InkWell(
                              child: Text(productList.product[index].name),
                              onTap: () async => showDialog(
                                  context: context,
                                  builder: (context) => FormDialogWidget(
                                      product: productList.product[index],
                                      onUpdate: _bloc.onTryChangeList.add)),
                            ),
                            leading: Text(
                                productList.product[index].price.toString()),
                            subtitle:
                                Text(productList.product[index].description),
                            trailing: IconButton(
                                onPressed: () => _bloc.onTryChangeList.add(
                                    RemoveProduct(
                                        productList.product[index].id!)),
                                icon: const Icon(Icons.delete)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showAddProductFormulary = !showAddProductFormulary;
                          },
                          child: const Text('Adicione um Produto'))
                    ])),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text('Novo Produto'),
                              const SizedBox(height: 15),
                              CustomTextField(
                                label: 'Nome',
                                onSave: (text) => name = text!,
                                onValidate: (text) =>
                                    (text == null || text.isEmpty)
                                        ? 'Preencha o campo'
                                        : null,
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                label: 'Preço',
                                onSave: (text) => price = double.parse(text!),
                                onValidate: (text) =>
                                    (text == null || text.isEmpty)
                                        ? 'Preencha o campo'
                                        : null,
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                label: 'Descrição',
                                onSave: (text) => description = text!,
                                onValidate: (text) =>
                                    (text == null || text.isEmpty)
                                        ? 'Preencha o campo'
                                        : null,
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      _bloc.onTryChangeList.add(AddProduct(
                                          Product(
                                              id: null,
                                              name: name,
                                              price: price,
                                              description: description)));
                                    }
                                  },
                                  child: const Text('Save'))
                            ],
                          ),
                        ))),
              ]);
            } else {
              return Center(
                child: ElevatedButton(
                    onPressed: () => _bloc.onTryNewSubjet.add(null),
                    child: const Text('Tente Novamentes')),
              );
            }
          } else {
            return const Text(' A lista esta vazia');
          }
        },
      ),
    );
  }
}
