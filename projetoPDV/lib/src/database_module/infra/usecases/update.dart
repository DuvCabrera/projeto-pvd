import '../../domain/domain.dart';
import '../infra.dart';

class Update extends IUpdate {
  final IDatabaseRepository repository;

  Update(this.repository);
  @override
  Future<void> update(
      {required int id,
      required Map<String, dynamic> data,
      required String tableName}) async {
    try {
      await repository.updateData(tableName: tableName, id: id, data: data);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }
}
