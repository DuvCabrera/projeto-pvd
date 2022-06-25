import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/database_module.dart';
import 'package:projeto_pvd/src/product_module/external/external.dart';

import 'product_storage_test.mocks.dart';

@GenerateMocks([IRead, IDelete, IUpdate, ICreate])
void main() {
  late ProductDatasource sut;
  late int id;
  late Map<String, dynamic> data;
  late String tableName;
  late ICreate create;
  late IDelete delete;
  late IRead read;
  late IUpdate update;

  setUp(() {
    create = MockICreate();
    read = MockIRead();
    update = MockIUpdate();
    delete = MockIDelete();
    sut = ProductDatasource(
        readData: read,
        deleteData: delete,
        updateData: update,
        createData: create);
    id = 1;
    tableName = 'table';
    data = {};
  });

  PostExpectation mockRepository(String type) {
    if (type == 'create') {
      return when(create.create(data: data, tableName: tableName));
    }
    if (type == 'read') {
      return when(read.read(tableName: tableName, id: id));
    }
    if (type == 'delete') {
      return when(delete.delete(id: id, tableName: tableName));
    }
    if (type == 'update') {
      return when(update.update(id: id, tableName: tableName, data: data));
    }
    throw Exception();
  }

  void mockSuccess(String type) {
    if (type == 'read') {
      mockRepository(type).thenAnswer((realInvocation) async => [data]);
    }
  }

  void mockFail(error, String type) {
    if (type == 'create') {
      mockRepository('create').thenThrow(error);
    }
    if (type == 'read') {
      mockRepository('read').thenThrow(error);
    }
    if (type == 'delete') {
      mockRepository(type).thenThrow(error);
    }
    if (type == 'update') {
      mockRepository(type).thenThrow(error);
    }
  }

  group('read', () {
    test('call the right params', () async {
      mockSuccess('read');
      await sut.read(tableName: tableName, id: id);
      verify(read.read(tableName: tableName, id: id));
    });
    test('should return the rigth data', () async {
      mockSuccess('read');
      final response = await sut.read(tableName: tableName, id: id);
      expect(response, [{}]);
    });
    test('shoul throw databaseError if throws', () {
      mockFail(Exception(), 'read');
      final future = sut.read(tableName: tableName, id: id);
      expect(future, throwsA(DatabaseError.unexpected));
    });
  });

  group('update', () {
    test('call the right params', () async {
      await sut.update(data: data, tableName: tableName, id: id);
      verify(update.update(id: id, data: data, tableName: tableName));
    });

    test('shoul throw databaseError if throws', () {
      mockFail(Exception(), 'update');
      final future = sut.update(tableName: tableName, id: id, data: data);
      expect(future, throwsA(DatabaseError.unexpected));
    });
  });

  group('delete', () {
    test('call the right params', () async {
      await sut.delete(tableName: tableName, id: id);
      verify(delete.delete(id: id, tableName: tableName));
    });

    test('shoul throw databaseError if throws', () {
      mockFail(Exception(), 'delete');
      final future = sut.delete(
        tableName: tableName,
        id: id,
      );
      expect(future, throwsA(DatabaseError.unexpected));
    });
  });

  group('create', () {
    test('call the right params', () async {
      await sut.create(tableName: tableName, data: data);
      verify(create.create(data: data, tableName: tableName));
    });

    test('shoul throw databaseError if throws', () {
      mockFail(Exception(), 'create');
      final future = sut.create(
        tableName: tableName,
        data: data,
      );
      expect(future, throwsA(DatabaseError.unexpected));
    });
  });
}
