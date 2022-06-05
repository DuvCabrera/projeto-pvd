// Mocks generated by Mockito 5.2.0 from annotations
// in projeto_pvd/test/src/database_module/external/repositories/database_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projeto_pvd/src/database_module/external/datasources/database_adapter.dart'
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

/// A class which mocks [IDatabaseAdapter].
///
/// See the documentation for Mockito's code generation for more information.
class MockIDatabaseAdapter extends _i1.Mock implements _i2.IDatabaseAdapter {
  MockIDatabaseAdapter() {
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
  _i3.Future<List<Map<String, dynamic>>> readData(
          {int? id, String? tableName}) =>
      (super.noSuchMethod(
          Invocation.method(#readData, [], {#id: id, #tableName: tableName}),
          returnValue: Future<List<Map<String, dynamic>>>.value(
              <Map<String, dynamic>>[])) as _i3
          .Future<List<Map<String, dynamic>>>);
  @override
  _i3.Future<void> deleteData({int? id, String? tableName}) =>
      (super.noSuchMethod(
          Invocation.method(#deleteData, [], {#id: id, #tableName: tableName}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> update(
          {int? id, String? tableName, Map<String, dynamic>? data}) =>
      (super.noSuchMethod(
          Invocation.method(
              #update, [], {#id: id, #tableName: tableName, #data: data}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}
