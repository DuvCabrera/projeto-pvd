import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_pvd/src/product_module/product_module.dart';
import 'package:provider/provider.dart' hide Create;
import 'package:provider/single_child_widget.dart';

import 'src/database_module/database_module.dart';

List<SingleChildWidget> providers = [
  ...withoutDependency,
  ...dependent,
];

List<SingleChildWidget> withoutDependency = [
  Provider(create: (context) => AppDatabase()),
  Provider(
    create: (context) => GoRouter(routes: [
      GoRoute(
          name: "product",
          path: '/',
          pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey, child: ProductPage.create(context)))
    ]),
  )
];

List<SingleChildWidget> dependent = [
  ///Database
  ProxyProvider<AppDatabase, DatabaseAdapter>(
      update: (context, appDatabase, dataBaseAdapter) =>
          DatabaseAdapter(appDatabase)),
  ProxyProvider<DatabaseAdapter, DatabaseRepository>(
      update: (context, databaseAdapter, databaseRepository) =>
          DatabaseRepository(databaseAdapter)),
  ProxyProvider<DatabaseRepository, Create>(
      update: (context, databaseRepository, create) =>
          Create(databaseRepository)),
  ProxyProvider<DatabaseRepository, Delete>(
      update: (context, databaseRepository, delete) =>
          Delete(databaseRepository)),
  ProxyProvider<DatabaseRepository, Update>(
      update: (context, databaseRepository, update) =>
          Update(databaseRepository)),
  ProxyProvider<DatabaseRepository, Read>(
      update: (context, databaseRepository, read) => Read(databaseRepository)),

  //Product
  ProxyProvider4<Read, Delete, Create, Update, ProductDatasource>(
      update: (_, read, delete, create, update, __) => ProductDatasource(
          createData: create,
          deleteData: delete,
          updateData: update,
          readData: read)),
  ProxyProvider<ProductDatasource, UpdateProductRepository>(
      update: (_, productDatasource, __) =>
          UpdateProductRepository(productDatasource)),
  ProxyProvider<ProductDatasource, CreateProductRepository>(
      update: (_, productDatasource, __) =>
          CreateProductRepository(productDatasource)),
  ProxyProvider<ProductDatasource, ReadProductRepository>(
      update: (_, productDatasource, __) =>
          ReadProductRepository(productDatasource)),
  ProxyProvider<ProductDatasource, DeleteProductRepository>(
      update: (_, productDatasource, __) =>
          DeleteProductRepository(productDatasource)),
  ProxyProvider<UpdateProductRepository, UpdateProduct>(
      update: (_, updateProductRepository, __) => UpdateProduct(
          repository: updateProductRepository, tableName: 'product')),
  ProxyProvider<ReadProductRepository, ReadProduct>(
      update: (_, readProductRepository, __) =>
          ReadProduct(repository: readProductRepository, tableName: 'product')),
  ProxyProvider<DeleteProductRepository, DeleteProduct>(
      update: (_, deleteProductRepository, __) => DeleteProduct(
          repository: deleteProductRepository, tableName: 'product')),
  ProxyProvider<CreateProductRepository, CreateProduct>(
      update: (_, createProductRepository, __) => CreateProduct(
          repository: createProductRepository, tableName: 'product')),
];
