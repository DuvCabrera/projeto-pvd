import '../../domain/domain.dart';
import '../infra.dart';

class Create extends ICreate {
  final IDatabaseRepository repository;

  Create(this.repository);
  @override
  Future<void> create(
      {required Map<String, dynamic> data, required String tableName}) async {
    try {
      await repository.createData(data: data, tableName: tableName);
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }
}
