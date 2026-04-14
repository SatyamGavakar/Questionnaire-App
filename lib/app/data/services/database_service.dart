import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/submission_model.dart';

class DatabaseService extends GetxService {
  static const _table = 'submissions';
  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'questionnaire_app.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_table(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            questionnaireId TEXT NOT NULL,
            dateTime TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertSubmission(SubmissionModel submission) async {
    final db = await database;
    return db.insert(_table, submission.toMap());
  }

  Future<List<SubmissionModel>> fetchSubmissions() async {
    final db = await database;
    final rows = await db.query(_table, orderBy: 'dateTime DESC');
    return rows.map(SubmissionModel.fromMap).toList();
  }
}
