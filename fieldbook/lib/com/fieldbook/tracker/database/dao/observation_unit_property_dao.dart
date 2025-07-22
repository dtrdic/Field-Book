import 'package:sqflite/sqflite.dart';

class ObservationUnitPropertyDao {
  final Database db;

  ObservationUnitPropertyDao(this.db);

  Future<List<String>> getRangeColumnNames() async {
    final cursor = await db.rawQuery('SELECT * FROM range LIMIT 1');
    if (cursor.isEmpty) return [];
    final columnNames = cursor.first.keys
        .where((col) => col != 'id')
        .map((col) => col.replaceAll('//', '/'))
        .toList();
    return columnNames;
  }
}
