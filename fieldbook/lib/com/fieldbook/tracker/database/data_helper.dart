import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/observation_dao.dart';
import 'dao/observation_unit_property_dao.dart';
import 'dao/study_dao.dart';
import 'dao/visible_observation_variable_dao.dart';
import 'models/field_object.dart';
import 'models/trait_object.dart';

class DataHelper {
  static const String dbName = 'fieldbook.db';

  late final Database db;
  late final StudyDao studyDao;
  late final ObservationUnitPropertyDao observationUnitPropertyDao;
  late final VisibleObservationVariableDao visibleObservationVariableDao;
  late final ObservationDao observationDao;

  DataHelper._(this.db) {
    studyDao = StudyDao(db);
    observationUnitPropertyDao = ObservationUnitPropertyDao(db);
    visibleObservationVariableDao = VisibleObservationVariableDao(db);
    observationDao = ObservationDao(db);
  }

  static Future<DataHelper> open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    final db = await openDatabase(path);
    return DataHelper._(db);
  }

  Future<List<FieldObject>> getAllFields(
      {String sortOrder = 'date_import'}) async {
    return await studyDao.getAllFields(sortOrder: sortOrder);
  }

  Future<List<String>> getRangeColumnNames() async {
    return await observationUnitPropertyDao.getRangeColumnNames();
  }

  Future<List<String>> getVisibleTrait() async {
    return await visibleObservationVariableDao.getVisibleTrait();
  }

  Future<Map<String, String>> getUserDetail(String plotId) async {
    return await observationDao.getUserDetail(plotId);
  }

  Future<TraitObject?> getDetail(String trait) async {
    return await visibleObservationVariableDao.getDetail(trait);
  }
}
