import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() async {
  // Configuración de FFI
  sqfliteFfiInit();
  // Usar la fábrica de bases de datos FFI
  final databaseFactory = databaseFactoryFfi;
  // Abrir o crear una base de datos
  final dbPath =
      join(await databaseFactory.getDatabasesPath(), 'my_database.db');
  final db = await databaseFactory.openDatabase(dbPath);
  print('Base de datos inicializada en: $dbPath');

  // Crear tabla:
/*  await db.execute('''
 CREATE TABLE users (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 name TEXT NOT NULL,
 age INTEGER NOT NULL
 )
''');
  print('Tabla creada: users');*/

  // Insertar datos:
  final userId = await db.insert('users', {
    'name': 'John Doe',
    'age': 30,
  });
  print('Usuario insertado con ID: $userId');

  // Consultar datos:
  final users = await db.query('users');
  for (var user in users) {
    print('Usuario: ${user['name']}, Edad: ${user['age']}');
  }

  // Actualizar datos:
  await db.update(
    'users',
    {'age': 35},
    where: 'name = ?',
    whereArgs: ['John Doe'],
  );
  print('Edad actualizada para John Doe.');

  // Eliminar datos:
  await db.delete(
    'users',
    where: 'age > ?',
    whereArgs: [30],
  );
  print('Usuarios mayores de 30 eliminados.');
}
