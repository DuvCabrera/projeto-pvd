// Mocks generated by Mockito 5.2.0 from annotations
// in projeto_pvd/test/src/comanda_module/infra/usecases/create_comanda_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:projeto_pvd/src/comanda_module/infra/infra.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [ICreateComandaRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockICreateComandaRepository extends _i1.Mock
    implements _i2.ICreateComandaRepository {
  MockICreateComandaRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> create({_i2.ComandaCM? data}) =>
      (super.noSuchMethod(Invocation.method(#create, [], {#data: data}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}
