import 'package:projeto_pvd/src/product_module/presenter/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/usecases.dart';

class ProductBloc {
  ProductBloc(this.create, this.delete, this.read, this.udate) {
    _productSubject.stream.flatMap((value) => _fetchProducts());
  }

  final ICreateProduct create;
  final IDeleteProduct delete;
  final IReadProduct read;
  final IUpdateProduct udate;

  final _productSubject = BehaviorSubject<ProductState>();
  Stream<ProductState> get onNewSubject => _productSubject.stream;

  Stream<ProductState> _fetchProducts() async* {
    yield Loading();
    try {
      yield Success(await read.readProducts());
    } catch (e) {
      yield Error();
    }
  }
}
