import 'package:sqflite/sqflite.dart';

import '../models/trait_object.dart';

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

  Future<TraitObject?> getDetail(String trait) async {
    final result = await db.rawQuery(
      'SELECT * FROM VisibleObservationVariable WHERE observation_variable_name = ?',
      [trait],
    );
    if (result.isEmpty) return null;
    final traitMap = result.first;
    return TraitObject.fromMap(traitMap);
  }
}
