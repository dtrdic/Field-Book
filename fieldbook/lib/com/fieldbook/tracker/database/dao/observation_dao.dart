import 'package:sqflite/sqflite.dart';

class ObservationDao {
  final Database db;
  ObservationDao(this.db);

  /// Returns a map of trait name to value for a given plotId (observation unit id)
  Future<Map<String, String>> getUserDetail(String plotId) async {
    final List<Map<String, dynamic>> result = await db.query(
      'observations',
      columns: [
        'observation_variable_name',
        'value',
      ],
      where: 'observation_unit_id = ?',
      whereArgs: [plotId],
    );
    return {
      for (final row in result)
        if (row['observation_variable_name'] != null && row['value'] != null)
          row['observation_variable_name'] as String: row['value'].toString()
    };
  }
}
