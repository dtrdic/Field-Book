import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/study_dao.dart';
import 'models/field_object.dart';

class DataHelper {
  static const String dbName = 'fieldbook.db';

  late final Database db;
  late final StudyDao studyDao;

  DataHelper._(this.db) {
    studyDao = StudyDao(db);
  }

  static Future<DataHelper> open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    final db = await openDatabase(path);
    return DataHelper._(db);
  }

  Future<List<FieldObject>> getAllFields({String sortOrder = 'date_import'}) async {
    return await studyDao.getAllFields(sortOrder: sortOrder);
  }
}
