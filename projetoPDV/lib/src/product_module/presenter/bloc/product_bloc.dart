import 'package:projeto_pvd/src/product_module/presenter/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/usecases.dart';

class ProductBloc {
  ProductBloc(this.create, this.delete, this.read, this.update) {
    _subscriptions
      ..add(Rx.merge(<Stream>[Stream.value(null), _onTryNewSubject])
          .flatMap((_) => _fetchProducts())
          .listen(_productSubject.add))
      ..add(_onTryChangeList
          .flatMap((event) => _changeList(event))
          .listen(_productSubject.add));
  }

  final ICreateProduct create;
  final IDeleteProduct delete;
  final IReadProduct read;
  final IUpdateProduct update;

  final _subscriptions = CompositeSubscription();

  final _productSubject = BehaviorSubject<ProductState>();
  Stream<ProductState> get onNewSubject => _productSubject.stream;

  final _onTryNewSubject = PublishSubject<void>();
  Sink<void> get onTryNewSubjet => _onTryNewSubject.sink;

  final _onTryChangeList = PublishSubject<ProductEvent>();
  Sink<ProductEvent> get onTryChangeList => _onTryChangeList.sink;

  Stream<ProductState> _fetchProducts() async* {
    yield Loading();
    try {
      yield Success(await read.readProducts());
    } catch (e) {
      yield Error();
    }
  }

  Stream<ProductState> _changeList(ProductEvent event) async* {
    yield Loading();
    try {
      if (event is AddProduct) {
        await create.createProduct(event.product);
      } else if (event is RemoveProduct) {
        await delete.deleteProduct(event.id);
      }
      yield Success(await read.readProducts());
    } catch (e) {
      yield Error();
    }
  }

  void dispose() {
    _productSubject.close();
  }
}
