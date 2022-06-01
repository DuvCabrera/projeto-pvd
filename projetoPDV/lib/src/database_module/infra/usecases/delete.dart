import '../../domain/domain.dart';
import '../repositories/repositories.dart';

class Delete extends IDelete {
  final IDatabaseRepository repository;

  Delete(this.repository);
  @override
  Future<void> delete({required int id, required String tableName}) async {
    try {
      await repository.deleteData(id: id, tableName: tableName);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }
}
