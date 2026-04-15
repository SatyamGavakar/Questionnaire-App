import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';
import '../models/submission_model.dart';

class DatabaseService extends GetxService {
  static const _submissionsTable = 'submissions';
  static const _usersTable = 'users';
  static const _submissionsUniqueIndex = 'idx_submissions_user_questionnaire';
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
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_usersTable(
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            phone TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
        await db.execute(
          'CREATE UNIQUE INDEX idx_users_email ON $_usersTable(email)',
        );
        await db.execute(
          'CREATE UNIQUE INDEX idx_users_phone ON $_usersTable(phone)',
        );
        await db.execute('''
          CREATE TABLE $_submissionsTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT NOT NULL,
            questionnaireId TEXT NOT NULL,
            dateTime TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            answersJson TEXT NOT NULL DEFAULT '{}'
          )
        ''');
        await db.execute(
          'CREATE UNIQUE INDEX $_submissionsUniqueIndex ON $_submissionsTable(userId, questionnaireId)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS $_usersTable(
              id TEXT PRIMARY KEY,
              name TEXT NOT NULL,
              email TEXT NOT NULL,
              phone TEXT NOT NULL,
              password TEXT NOT NULL
            )
          ''');
          await db.execute(
            'CREATE UNIQUE INDEX IF NOT EXISTS idx_users_email ON $_usersTable(email)',
          );
          await db.execute(
            'CREATE UNIQUE INDEX IF NOT EXISTS idx_users_phone ON $_usersTable(phone)',
          );

          final columns =
              (await db.rawQuery('PRAGMA table_info($_submissionsTable)'))
                  .map((e) => (e['name'] as String?) ?? '')
                  .toSet();
          if (!columns.contains('userId')) {
            await db.execute(
              'ALTER TABLE $_submissionsTable ADD COLUMN userId TEXT NOT NULL DEFAULT ""',
            );
          }

          await db.execute(
            'CREATE UNIQUE INDEX IF NOT EXISTS $_submissionsUniqueIndex ON $_submissionsTable(userId, questionnaireId)',
          );
        }
        if (oldVersion < 3) {
          final columns =
              (await db.rawQuery('PRAGMA table_info($_submissionsTable)'))
                  .map((e) => (e['name'] as String?) ?? '')
                  .toSet();
          if (!columns.contains('answersJson')) {
            await db.execute(
              'ALTER TABLE $_submissionsTable ADD COLUMN answersJson TEXT NOT NULL DEFAULT "{}"',
            );
          }
        }
      },
    );
  }

  Future<int> insertSubmission(SubmissionModel submission) async {
    final db = await database;
    return db.insert(
      _submissionsTable,
      submission.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<List<SubmissionModel>> fetchSubmissions({String? userId}) async {
    final db = await database;
    final rows = await db.query(
      _submissionsTable,
      where: userId == null ? null : 'userId = ?',
      whereArgs: userId == null ? null : [userId],
      orderBy: 'dateTime DESC',
    );
    return rows.map(SubmissionModel.fromMap).toList();
  }

  Future<bool> hasSubmitted({
    required String userId,
    required String questionnaireId,
  }) async {
    final db = await database;
    final rows = await db.query(
      _submissionsTable,
      columns: ['id'],
      where: 'userId = ? AND questionnaireId = ?',
      whereArgs: [userId, questionnaireId],
      limit: 1,
    );
    return rows.isNotEmpty;
  }

  Future<UserModel?> findUserByPhoneOrEmail(String phoneOrEmail) async {
    final db = await database;
    final rows = await db.query(
      _usersTable,
      where: 'phone = ? OR email = ?',
      whereArgs: [phoneOrEmail, phoneOrEmail],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return UserModel.fromMap(rows.first);
  }

  Future<UserModel?> getUserById(String id) async {
    final db = await database;
    final rows = await db.query(
      _usersTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return UserModel.fromMap(rows.first);
  }

  Future<bool> userExistsByPhoneOrEmail(String phone, String email) async {
    final db = await database;
    final rows = await db.query(
      _usersTable,
      columns: ['id'],
      where: 'phone = ? OR email = ?',
      whereArgs: [phone, email],
      limit: 1,
    );
    return rows.isNotEmpty;
  }

  Future<void> insertUser({
    required UserModel user,
    required String password,
  }) async {
    final db = await database;
    await db.insert(
      _usersTable,
      {
        ...user.toMap(),
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<bool> validateUserCredentials({
    required String phoneOrEmail,
    required String password,
  }) async {
    final db = await database;
    final rows = await db.query(
      _usersTable,
      columns: ['id'],
      where: '(phone = ? OR email = ?) AND password = ?',
      whereArgs: [phoneOrEmail, phoneOrEmail, password],
      limit: 1,
    );
    return rows.isNotEmpty;
  }
}
