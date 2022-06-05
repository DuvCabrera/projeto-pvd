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
        throw DatabaseError.invelidData;
      }
      await database.createData(data: data, tableName: tableName);
    } on DatabaseError catch (e) {
      e == DatabaseError.invelidData
          ? throw DatabaseError.invelidData
          : throw DatabaseError.unexpected;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> deleteData({required int id, required String tableName}) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> readData(
      {required String tableName, int? id}) async {
    try {
      return await database.readData(tableName: tableName, id: id);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }

  @override
  Future<void> updateData(
      {required int id,
      required Map<String, dynamic> data,
      required String tableName}) {
    // TODO: implement updateData
    throw UnimplementedError();
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
    throw Exception();
  }

  void mockFailCreate(error, String type) {
    if (type == 'create') {
      mockRepository('create').thenThrow(error);
    }
    if (type == 'read') {
      mockRepository('read').thenThrow(error);
    }
  }

  group('testing create', () {
    test('create must call the right params', () async {
      await sut.createData(data: data, tableName: tableName);
      verify(database.createData(data: data, tableName: tableName));
    });

    test('should throw Database Errror if throws', () {
      mockFailCreate(Exception(), 'create');
      final future = sut.createData(data: data, tableName: tableName);
      expect(future, throwsA(DatabaseError.unexpected));
    });

    test(
        'should throws Database Error invalid data thros Database Error invalid',
        () {
      mockFailCreate(DatabaseError.invelidData, 'create');
      final future = sut.createData(data: data, tableName: tableName);
      expect(future, throwsA(DatabaseError.invelidData));
    });

    test('should throw DatabaseError InvalidData on tableName or data empty',
        () {
      final future = sut.createData(data: {}, tableName: tableName);
      expect(future, throwsA(DatabaseError.invelidData));

      final future2 = sut.createData(data: data, tableName: '');
      expect(future2, throwsA(DatabaseError.invelidData));
    });
  });

  group('read', () {
    test('create must call right params', () async {
      mockRepository('read');
      final result = await sut.readData(tableName: tableName, id: id);
      verify(database.readData(tableName: tableName, id: id));
    });
  });
}
