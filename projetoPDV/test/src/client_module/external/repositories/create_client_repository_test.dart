import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/client_module/client_module.dart';
import 'package:projeto_pvd/src/client_module/external/datasources/client_datasource.dart';
import 'package:projeto_pvd/src/core_module/core_module.dart';

import 'create_client_repository_test.mocks.dart';

@GenerateMocks([IClientDatasource])
void main() {
  late CreateClientRepository sut;
  late IClientDatasource datasource;
  late String tableName;
  late Map<String, dynamic> data;

  setUp(() {
    tableName = 'table';
    data = {};
    datasource = MockIClientDatasource();
    sut = CreateClientRepository(datasource);
  });

  PostExpectation mockRepository() {
    return when(datasource.create(data: data, tableName: tableName));
  }

  void mockResponseThrow(error) {
    mockRepository().thenThrow(error);
  }

  test('create call the right paranms', () async {
    await sut.create(data: data, tableName: tableName);
    verify(datasource.create(data: data, tableName: tableName));
  });
  test('create must thow externalerror.unexpected if throw', () {
    mockResponseThrow(Exception());
    final future = sut.create(data: data, tableName: tableName);
    expect(future, throwsA(ExternalError.unexpected));
  });
}
