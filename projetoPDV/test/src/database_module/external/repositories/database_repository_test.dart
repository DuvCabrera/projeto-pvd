import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_pvd/src/database_module/domain/domain.dart';

import 'package:projeto_pvd/src/database_module/external/external.dart';
import 'package:projeto_pvd/src/database_module/infra/infra.dart';

import 'database_repository_test.mocks.dart';

class DatabaseRepository extends IDatabaseRepository {
  final IDatabaseAdapter database;

  DatabaseRepository(this.database);
  @override
  Future<void> createData(
      {required Map<String, dynamic> data, required String tableName}) async {
    try {
      if (data.isEmpty || tableName.isEmpty) {
        throw DatabaseError.invalidData;
      }
      await database.createData(data: data, tableName: tableName);
    } on DatabaseError catch (e) {
      e == DatabaseError.invalidData
          ? throw DatabaseError.invalidData
          : throw DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> deleteData({required int id, required String tableName}) async {
    try {
      if (tableName.isEmpty) {
        throw DatabaseError.invalidData;
      }
      await database.deleteData(id: id, tableName: tableName);
    } on DatabaseError catch (e) {
      e == DatabaseError.invalidData
          ? throw DatabaseError.invalidData
          : throw DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> readData(
      {required String tableName, int? id}) async {
    try {
      if (tableName.isEmpty) {
        throw DatabaseError.invalidData;
      }
      return await database.readData(tableName: tableName, id: id);
    } on DatabaseError catch (e) {
      e == DatabaseError.invalidData
          ? throw DatabaseError.invalidData
          : throw DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> updateData(
      {required int id,
      required Map<String, dynamic> data,
      required String tableName}) async {
    try {
      if (data.isEmpty || tableName.isEmpty) {
        throw DatabaseError.invalidData;
      }
      await database.update(id: id, tableName: tableName, data: data);
    } on DatabaseError catch (e) {
      e == DatabaseError.invalidData
          ? throw DatabaseError.invalidData
          : DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }
}

@GenerateMocks([IDatabaseAdapter])
void main() {
  late DatabaseRepository sut;
  late IDatabaseAdapter database;
  late String tableName;
  late Map<String, dynamic> data;
  late int id;

  setUp(() {
    database = MockIDatabaseAdapter();
    sut = DatabaseRepository(database);
    tableName = 'table';
    data = {};
    id = 1;
  });

  PostExpectation mockRepository(String type) {
    if (type == 'create') {
      return when(database.createData(data: data, tableName: tableName));
    }
    if (type == 'read') {
      return when(database.readData(tableName: tableName, id: id));
    }
    if (type == 'delete') {
      return when(database.deleteData(id: id, tableName: tableName));
    }
    if (type == 'update') {
      return when(database.update(id: id, tableName: tableName, data: data));
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

  group('testing create', () {
    test('create must call the right params', () async {
      await sut.createData(data: data, tableName: tableName);
      verify(database.createData(data: data, tableName: tableName));
    });

    test('should throw Database Errror if throws', () {
      mockFail(Exception(), 'create');
      final future = sut.createData(data: data, tableName: tableName);
      expect(future, throwsA(DatabaseError.unexpected));
    });

    test(
        'should throws Database Error invalid data thros Database Error invalid',
        () {
      mockFail(DatabaseError.invalidData, 'create');
      final future = sut.createData(data: data, tableName: tableName);
      expect(future, throwsA(DatabaseError.invalidData));
    });

    test('should throw DatabaseError InvalidData on tableName or data empty',
        () {
      final future = sut.createData(data: {}, tableName: tableName);
      expect(future, throwsA(DatabaseError.invalidData));

      final future2 = sut.createData(data: data, tableName: '');
      expect(future2, throwsA(DatabaseError.invalidData));
    });
  });

  group('read', () {
    test('read must call right params', () async {
      mockSuccess('read');
      final result = await sut.readData(tableName: tableName, id: id);
      verify(database.readData(tableName: tableName, id: id));
    });
    test('read should throws database error unexpected when throws', () {
      mockFail(Exception(), 'read');
      final future = sut.readData(tableName: tableName, id: id);
      expect(future, throwsA(DatabaseError.unexpected));
    });

    test('should throws database.invalidData if tableName is empty', () {
      final future = sut.readData(tableName: '');
      expect(future, throwsA(DatabaseError.invalidData));
    });
  });

  group('delete', () {
    test('should call the right paramns', () async {
      await sut.deleteData(id: id, tableName: tableName);
      verify(database.deleteData(id: id, tableName: tableName));
    });

    test('should throw databaseError unexpected if throws', () {
      mockFail(Exception(), 'delete');
      final future = sut.deleteData(id: id, tableName: tableName);
      expect(future, throwsA(DatabaseError.unexpected));
    });

    test('should throw databaseError.invalidData when table name is empty ',
        () {
      final future = sut.deleteData(id: id, tableName: '');
      expect(future, throwsA(DatabaseError.invalidData));
    });
  });

  group('update', () {
    test('should call the right params', () async {
      await sut.updateData(id: id, data: data, tableName: tableName);
      verify(database.update(id: id, tableName: tableName, data: data));
    });

    test('should throw DatabaseError unexpected if trhows', () {
      mockFail(Exception(), 'update');
      final future = sut.updateData(id: id, data: data, tableName: tableName);
      expect(future, throwsA(DatabaseError.unexpected));
    });

    test('shold throw invalidData if invalid params are used', () {
      final future = sut.updateData(id: id, data: {}, tableName: tableName);
      expect(future, throwsA(DatabaseError.invalidData));
      final future2 = sut.updateData(id: id, data: data, tableName: '');
      expect(future2, throwsA(DatabaseError.invalidData));
    });
  });
}
