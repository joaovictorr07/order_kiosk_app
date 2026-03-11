import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const String _databaseName = 'order_kiosk.db';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    final existingDatabase = _database;
    if (existingDatabase != null) {
      return existingDatabase;
    }

    final openedDatabase = await _openDatabase();
    _database = openedDatabase;
    return openedDatabase;
  }

  Future<void> close() async {
    final existingDatabase = _database;
    if (existingDatabase == null) {
      return;
    }

    await existingDatabase.close();
    _database = null;
  }

  Future<Database> _openDatabase() async {
    final directory = await getApplicationSupportDirectory();
    final databasePath = path.join(directory.path, _databaseName);

    return openDatabase(
      databasePath,
      version: _databaseVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Estrutura inicial será adicionada conforme os módulos forem surgindo.
  }
}
