import 'package:projeto_pvd/src/product_module/presenter/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/domain.dart';

class ProductBloc {
  ProductBloc(this.create, this.delete, this.read, this.update) {
    _subscriptions
      ..add(Rx.merge(<Stream>[Stream.value(null), _onTryNewSubject])
          .flatMap((_) => _fetchProducts())
          .listen(_productSubject.add))
      ..add(_onTryChangeList
          .flatMap((event) => _changeList(event))
          .listen(_productSubject.add))
      ..add(_onSearchProduct
          .flatMap((value) => _searchProducts(value))
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

  final _onSearchProduct = PublishSubject<String>();
  Sink<String> get onSearchProduct => _onSearchProduct.sink;

  Stream<ProductState> _searchProducts(String value) async* {
    ProductState state = _productSubject.value;
    List<Product> newList = [];

    if (state is Loading) {
      yield Loading();
    } else if (state is Success) {
      if (value.isEmpty) {
        onTryNewSubjet.add(null);
      } else {
        newList = state.product
            .where((element) => element.name.contains(value))
            .toList();
        yield Success(newList);
      }
    }
  }

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
      } else if (event is UpdateProducts) {
        await update.updateProducts(
            id: event.product.id!, entity: event.product);
      }
      yield Success(await read.readProducts());
    } catch (e) {
      yield Error();
    }
  }

  void dispose() {
    _productSubject.close();
    _subscriptions.dispose();
    _onTryNewSubject.close();
    _onTryChangeList.close();
    _onSearchProduct.close();
  }
}
