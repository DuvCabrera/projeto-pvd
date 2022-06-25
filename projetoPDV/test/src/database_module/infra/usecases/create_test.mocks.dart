// Mocks generated by Mockito 5.2.0 from annotations
// in projeto_pvd/test/src/database_module/infra/usecases/create_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projeto_pvd/src/database_module/infra/repositories/database_repository.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [IDatabaseRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIDatabaseRepository extends _i1.Mock
    implements _i2.IDatabaseRepository {
  MockIDatabaseRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> createData(
          {Map<String, dynamic>? data, String? tableName}) =>
      (super.noSuchMethod(
          Invocation.method(
              #createData, [], {#data: data, #tableName: tableName}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> deleteData({int? id, String? tableName}) =>
      (super.noSuchMethod(
          Invocation.method(#deleteData, [], {#id: id, #tableName: tableName}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<List<Map<String, dynamic>>> readData(
          {String? tableName, int? id}) =>
      (super.noSuchMethod(
          Invocation.method(#readData, [], {#tableName: tableName, #id: id}),
          returnValue: Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[])) as _i3
          .Future<List<Map<String, dynamic>>>);
  @override
  _i3.Future<void> updateData(
          {String? tableName, int? id, Map<String, dynamic>? data}) =>
      (super.noSuchMethod(
          Invocation.method(
              #updateData, [], {#tableName: tableName, #id: id, #data: data}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}
