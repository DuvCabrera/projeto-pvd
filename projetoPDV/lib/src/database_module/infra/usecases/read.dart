import '../../domain/domain.dart';
import '../repositories/repositories.dart';

class Read extends IRead {
  final IDatabaseRepository repository;

  Read(this.repository);
  @override
  Future<List<Map<String, dynamic>>> read(
      {required String tableName, int? id}) async {
    try {
      final response = await repository.readData(tableName: tableName, id: id);
      return response;
    } catch (e) {
      throw DatabaseError.unexpected;
    }
  }
}
