import 'package:sqflite/sqflite.dart';
import '../models/field_object.dart';

class StudyDao {
  final Database db;
  StudyDao(this.db);

  Future<List<FieldObject>> getAllFields({String sortOrder = 'date_import'}) async {
    final isDateSort = sortOrder.startsWith('date_');
    final orderBy = sortOrder == 'visible' ? 'position' : sortOrder;
    final orderDir = isDateSort ? 'DESC' : 'ASC';
    final result = await db.rawQuery('''
      SELECT *,
        (SELECT COUNT(*) FROM observation_units_attributes WHERE study_id = studies.internal_id_study) AS attribute_count,
        (SELECT COUNT(DISTINCT observation_variable_name) FROM observations WHERE study_id = studies.internal_id_study AND observation_variable_db_id > 0) AS trait_count,
        (SELECT COUNT(*) FROM observations WHERE study_id = studies.internal_id_study AND observation_variable_db_id > 0) AS observation_count
      FROM studies
      ORDER BY $orderBy COLLATE NOCASE $orderDir
    ''');
    return result.map((e) => FieldObject.fromMap(e)).toList();
  }
}
