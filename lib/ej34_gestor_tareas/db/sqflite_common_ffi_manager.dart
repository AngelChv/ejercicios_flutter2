import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteManager {
  static Database? _db;


  static Future<Database?> get db async {
    if (_db == null || !_db!.isOpen) return await startDb();
    return _db;
  }

  static Future<Database?> startDb() async {
    // Configuración de FFI
    sqfliteFfiInit();
    // Usar la fábrica de bases de datos FFI
    final databaseFactory = databaseFactoryFfi;
    // Abrir o crear una base de datos
    final dbPath = join(await databaseFactory.getDatabasesPath(), 'tasks.db');
    _db = await databaseFactory.openDatabase(dbPath);
    return _db;
  }
}