import 'package:sqflite/sqflite.dart';

class VisibleObservationVariableDao {
  final Database db;

  VisibleObservationVariableDao(this.db);

  Future<List<String>> getVisibleTrait() async {
    final result = await db.rawQuery(
        'SELECT observation_variable_name FROM VisibleObservationVariable');
    return result
        .map((row) => row['observation_variable_name'] as String)
        .toList();
  }
}
